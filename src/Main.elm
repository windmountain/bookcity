port module Main exposing (main)

import Browser
import ChartOfAccounts exposing (Account, accounts)
import Dict exposing (Dict)
import Html exposing (Html, button, div, h2, input, label, option, p, select, text)
import Html.Attributes exposing (selected, type_, value)
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
    div []
        [ label [] [ text lbl ]
        , select [ onInput toMsg ]
            (option [ value "", selected (current == "") ] [ text "-- pick --" ]
                :: List.map (accountOption current) accounts
            )
        ]


view : Model -> Html Msg
view model =
    case model.remaining of
        [] ->
            div []
                [ h2 [] [ text "Done!" ]
                , p []
                    [ text
                        ("Score: "
                            ++ String.fromInt model.score
                            ++ " / "
                            ++ String.fromInt model.total
                        )
                    ]
                , button [ onClick ClearAll ] [ text "Clear Correct Answers" ]
                ]

        txn :: _ ->
            div []
                [ h2 [] [ text (txn.date ++ ": " ++ txn.description) ]
                , case model.feedback of
                    Nothing ->
                        div []
                            [ accountSelect "Debit: " SelectDebit model.selectedDebit
                            , accountSelect "Credit: " SelectCredit model.selectedCredit
                            , div []
                                [ label [] [ text "Amount: $" ]
                                , input [ type_ "text", value model.enteredAmount, onInput EnterAmount ] []
                                ]
                            , button [ onClick Submit ] [ text "Submit" ]
                            ]

                    Just correct ->
                        div []
                            [ p []
                                [ text
                                    (if correct then
                                        "Correct!"

                                     else
                                        "Not correct. Answer: Debit "
                                            ++ accountName txn.debitAccount
                                            ++ ", Credit "
                                            ++ accountName txn.creditAccount
                                            ++ ", "
                                            ++ formatCents txn.amount
                                    )
                                ]
                            , button [ onClick Next ] [ text "Next" ]
                            ]
                , button [ onClick ClearAll ] [ text "Clear Correct Answers" ]
                ]


main : Program Decode.Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
