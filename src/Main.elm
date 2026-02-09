port module Main exposing (main)

import Browser
import ChartOfAccounts exposing (Account, AccountType(..), accounts)
import Dict exposing (Dict)
import Html exposing (Html, button, div, h1, h2, input, label, optgroup, option, p, select, small, span, text)
import Html.Attributes exposing (attribute, class, placeholder, selected, type_, value)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode
import Json.Encode as Encode
import JanuaryTransactions exposing (Transaction, transactions)


port saveAnswer : Encode.Value -> Cmd msg


port clearAnswers : () -> Cmd msg


type alias SavedAnswer =
    { debit : String
    , credit : String
    , amount : String
    }


type alias Model =
    { remaining : List Transaction
    , selectedDebit : String
    , selectedCredit : String
    , enteredAmount : String
    , feedback : Maybe Bool
    , score : Int
    , total : Int
    , saved : Dict String SavedAnswer
    }


type Msg
    = SelectDebit String
    | SelectCredit String
    | EnterAmount String
    | Submit
    | Next
    | ClearAll


txnKey : Transaction -> String
txnKey txn =
    txn.date ++ ": " ++ txn.description


prefill : List Transaction -> Dict String SavedAnswer -> { debit : String, credit : String, amount : String }
prefill remaining saved =
    case remaining of
        txn :: _ ->
            case Dict.get (txnKey txn) saved of
                Just answer ->
                    answer

                Nothing ->
                    { debit = "", credit = "", amount = "" }

        [] ->
            { debit = "", credit = "", amount = "" }


init : Decode.Value -> ( Model, Cmd msg )
init flags =
    let
        saved =
            decodeFlags flags

        fields =
            prefill transactions saved
    in
    ( { remaining = transactions
      , selectedDebit = fields.debit
      , selectedCredit = fields.credit
      , enteredAmount = fields.amount
      , feedback = Nothing
      , score = 0
      , total = 0
      , saved = saved
      }
    , Cmd.none
    )


decodeFlags : Decode.Value -> Dict String SavedAnswer
decodeFlags flags =
    Decode.decodeValue
        (Decode.dict
            (Decode.map3 SavedAnswer
                (Decode.field "debit" Decode.string)
                (Decode.field "credit" Decode.string)
                (Decode.field "amount" Decode.string)
            )
        )
        flags
        |> Result.withDefault Dict.empty


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectDebit val ->
            ( { model | selectedDebit = val }, Cmd.none )

        SelectCredit val ->
            ( { model | selectedCredit = val }, Cmd.none )

        EnterAmount val ->
            ( { model | enteredAmount = val }, Cmd.none )

        Submit ->
            case model.remaining of
                txn :: _ ->
                    let
                        debitCorrect =
                            model.selectedDebit == String.fromInt txn.debitAccount

                        creditCorrect =
                            model.selectedCredit == String.fromInt txn.creditAccount

                        amountCorrect =
                            parseCents model.enteredAmount == Just txn.amount

                        correct =
                            debitCorrect && creditCorrect && amountCorrect

                        ( newSaved, cmd ) =
                            if correct then
                                let
                                    key =
                                        txnKey txn

                                    answer =
                                        SavedAnswer model.selectedDebit model.selectedCredit model.enteredAmount
                                in
                                ( Dict.insert key answer model.saved
                                , saveAnswer
                                    (Encode.object
                                        [ ( "key", Encode.string key )
                                        , ( "debit", Encode.string model.selectedDebit )
                                        , ( "credit", Encode.string model.selectedCredit )
                                        , ( "amount", Encode.string model.enteredAmount )
                                        ]
                                    )
                                )

                            else
                                ( model.saved, Cmd.none )
                    in
                    ( { model
                        | feedback = Just correct
                        , score =
                            model.score
                                + (if correct then
                                    1

                                   else
                                    0
                                  )
                        , total = model.total + 1
                        , saved = newSaved
                      }
                    , cmd
                    )

                [] ->
                    ( model, Cmd.none )

        Next ->
            case model.remaining of
                _ :: rest ->
                    let
                        fields =
                            prefill rest model.saved
                    in
                    ( { model
                        | remaining = rest
                        , selectedDebit = fields.debit
                        , selectedCredit = fields.credit
                        , enteredAmount = fields.amount
                        , feedback = Nothing
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model, Cmd.none )

        ClearAll ->
            let
                fields =
                    { debit = "", credit = "", amount = "" }
            in
            ( { remaining = transactions
              , selectedDebit = fields.debit
              , selectedCredit = fields.credit
              , enteredAmount = fields.amount
              , feedback = Nothing
              , score = 0
              , total = 0
              , saved = Dict.empty
              }
            , clearAnswers ()
            )


parseCents : String -> Maybe Int
parseCents str =
    let
        cleaned =
            String.replace "," "" str
                |> String.replace "$" ""
                |> String.trim
    in
    case String.split "." cleaned of
        [ whole ] ->
            String.toInt whole |> Maybe.map (\w -> w * 100)

        [ whole, frac ] ->
            let
                paddedFrac =
                    String.left 2 (frac ++ "0")
            in
            Maybe.map2 (\w f -> w * 100 + f)
                (String.toInt whole)
                (String.toInt paddedFrac)

        _ ->
            Nothing


accountName : Int -> String
accountName number =
    accounts
        |> List.filter (\a -> a.number == number)
        |> List.head
        |> Maybe.map .name
        |> Maybe.withDefault ("Unknown (" ++ String.fromInt number ++ ")")


formatCents : Int -> String
formatCents cents =
    let
        dollars =
            cents // 100

        remainder =
            modBy 100 cents
    in
    "$"
        ++ String.fromInt dollars
        ++ "."
        ++ String.padLeft 2 '0' (String.fromInt remainder)


accountTypeName : AccountType -> String
accountTypeName t =
    case t of
        Asset ->
            "Assets"

        ContraAsset ->
            "Contra Assets"

        Liability ->
            "Liabilities"

        Equity ->
            "Owner's Equity"

        Revenue ->
            "Revenue"

        Expense ->
            "Expenses"


accountGroups : List ( AccountType, List Account )
accountGroups =
    let
        types =
            [ Asset, ContraAsset, Liability, Equity, Revenue, Expense ]
    in
    List.filterMap
        (\t ->
            let
                matching =
                    List.filter (\a -> a.accountType == t) accounts
            in
            if List.isEmpty matching then
                Nothing

            else
                Just ( t, matching )
        )
        types


accountOption : String -> Account -> Html Msg
accountOption current acct =
    let
        val =
            String.fromInt acct.number
    in
    option [ value val, selected (current == val) ]
        [ text (val ++ " - " ++ acct.name) ]


accountSelect : String -> (String -> Msg) -> String -> Html Msg
accountSelect lbl toMsg current =
    div [ class "field" ]
        [ label [] [ text lbl ]
        , select [ onInput toMsg ]
            (option [ value "", selected (current == "") ] [ text "-- pick --" ]
                :: List.map
                    (\( t, accts ) ->
                        optgroup [ attribute "label" (accountTypeName t) ]
                            (List.map (accountOption current) accts)
                    )
                    accountGroups
            )
        ]


progress : Model -> Html Msg
progress model =
    let
        total =
            List.length transactions

        done =
            total - List.length model.remaining
    in
    small [ class "progress" ]
        [ text (String.fromInt (done + 1) ++ " / " ++ String.fromInt total) ]


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "title" ] [ text "Hamburger Lanes" ]
        , case model.remaining of
            [] ->
                div [ class "card done" ]
                    [ h2 [] [ text "Done!" ]
                    , p [ class "score" ]
                        [ text
                            (String.fromInt model.score
                                ++ " / "
                                ++ String.fromInt model.total
                            )
                        ]
                    , button [ class "btn btn-secondary", onClick ClearAll ] [ text "Start Over" ]
                    ]

            txn :: _ ->
                div [ class "card" ]
                    [ progress model
                    , h2 [ class "description" ] [ text (txn.date ++ ": " ++ txn.description) ]
                    , case model.feedback of
                        Nothing ->
                            div [ class "form" ]
                                [ accountSelect "Debit" SelectDebit model.selectedDebit
                                , accountSelect "Credit" SelectCredit model.selectedCredit
                                , div [ class "field" ]
                                    [ label [] [ text "Amount" ]
                                    , input
                                        [ type_ "text"
                                        , value model.enteredAmount
                                        , onInput EnterAmount
                                        , placeholder "0.00"
                                        ]
                                        []
                                    ]
                                , button [ class "btn", onClick Submit ] [ text "Submit" ]
                                ]

                        Just correct ->
                            div [ class "feedback" ]
                                [ p
                                    [ class
                                        (if correct then
                                            "result correct"

                                         else
                                            "result incorrect"
                                        )
                                    ]
                                    [ text
                                        (if correct then
                                            "Correct!"

                                         else
                                            "Not correct."
                                        )
                                    ]
                                , if not correct then
                                    p [ class "answer" ]
                                        [ text "Answer: "
                                        , span [ class "answer-detail" ] [ text (accountName txn.debitAccount) ]
                                        , text " / "
                                        , span [ class "answer-detail" ] [ text (accountName txn.creditAccount) ]
                                        , text (" for " ++ formatCents txn.amount)
                                        ]

                                  else
                                    text ""
                                , button [ class "btn", onClick Next ] [ text "Next" ]
                                ]
                    , button [ class "btn btn-link", onClick ClearAll ] [ text "Clear Correct Answers" ]
                    ]
        ]


main : Program Decode.Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
