module Main exposing (main)

import Browser
import ChartOfAccounts exposing (Account, accounts)
import Html exposing (Html, button, div, h2, input, label, option, p, select, text)
import Html.Attributes exposing (selected, type_, value)
import Html.Events exposing (onClick, onInput)
import JanuaryTransactions exposing (Transaction, transactions)


type alias Model =
    { remaining : List Transaction
    , selectedDebit : String
    , selectedCredit : String
    , enteredAmount : String
    , feedback : Maybe Bool
    , score : Int
    , total : Int
    }


type Msg
    = SelectDebit String
    | SelectCredit String
    | EnterAmount String
    | Submit
    | Next


init : Model
init =
    { remaining = transactions
    , selectedDebit = ""
    , selectedCredit = ""
    , enteredAmount = ""
    , feedback = Nothing
    , score = 0
    , total = 0
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectDebit val ->
            { model | selectedDebit = val }

        SelectCredit val ->
            { model | selectedCredit = val }

        EnterAmount val ->
            { model | enteredAmount = val }

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
                    in
                    { model
                        | feedback = Just correct
                        , score =
                            model.score
                                + (if correct then
                                    1

                                   else
                                    0
                                  )
                        , total = model.total + 1
                    }

                [] ->
                    model

        Next ->
            case model.remaining of
                _ :: rest ->
                    { model
                        | remaining = rest
                        , selectedDebit = ""
                        , selectedCredit = ""
                        , enteredAmount = ""
                        , feedback = Nothing
                    }

                [] ->
                    model


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


accountOption : Account -> Html Msg
accountOption acct =
    option [ value (String.fromInt acct.number) ]
        [ text (String.fromInt acct.number ++ " - " ++ acct.name) ]


accountSelect : String -> (String -> Msg) -> String -> Html Msg
accountSelect lbl toMsg current =
    div []
        [ label [] [ text lbl ]
        , select [ onInput toMsg ]
            (option [ value "", selected (current == "") ] [ text "-- pick --" ]
                :: List.map accountOption accounts
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
                ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
