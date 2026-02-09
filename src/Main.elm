port module Main exposing (main)

import Account exposing (Account, AccountType(..))
import AptPhotography.ChartOfAccounts as APC
import AptPhotography.Transactions as APT
import Browser
import Dict exposing (Dict)
import FaithfulVet.ChartOfAccounts as FVC
import FaithfulVet.Transactions as FVT
import Html exposing (Html, button, div, footer, h1, h2, header, input, label, main_, optgroup, option, p, select, small, span, text)
import Html.Attributes exposing (attribute, class, placeholder, selected, type_, value)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode
import Json.Encode as Encode
import KeystoneLanes.ChartOfAccounts as KLC
import KeystoneLanes.Transactions as KLT
import SoundFitness.ChartOfAccounts as SFC
import SoundFitness.Transactions as SFT
import SterlingBakery.ChartOfAccounts as SBC
import SterlingBakery.Transactions as SBT
import Transaction exposing (Transaction)
import TruelineAuto.ChartOfAccounts as TAC
import TruelineAuto.Transactions as TAT
import UprightLandscaping.ChartOfAccounts as ULC
import UprightLandscaping.Transactions as ULT


port saveAnswer : Encode.Value -> Cmd msg


port clearAnswers : () -> Cmd msg


type alias Business =
    { id : String
    , name : String
    , accounts : List Account
    , transactions : List Transaction
    }


businesses : List Business
businesses =
    [ { id = "keystone-lanes"
      , name = "Keystone Lanes"
      , accounts = KLC.accounts
      , transactions = KLT.transactions
      }
    , { id = "sterling-bakery"
      , name = "Sterling Bakery"
      , accounts = SBC.accounts
      , transactions = SBT.transactions
      }
    , { id = "faithful-vet"
      , name = "Faithful Veterinary Clinic"
      , accounts = FVC.accounts
      , transactions = FVT.transactions
      }
    , { id = "sound-fitness"
      , name = "Sound Fitness"
      , accounts = SFC.accounts
      , transactions = SFT.transactions
      }
    , { id = "upright-landscaping"
      , name = "Upright Landscaping"
      , accounts = ULC.accounts
      , transactions = ULT.transactions
      }
    , { id = "trueline-auto"
      , name = "Trueline Auto"
      , accounts = TAC.accounts
      , transactions = TAT.transactions
      }
    , { id = "apt-photography"
      , name = "Apt Photography"
      , accounts = APC.accounts
      , transactions = APT.transactions
      }
    ]


type alias SavedAnswer =
    { debit : String
    , credit : String
    , amount : String
    }


type Page
    = ChoosingBusiness
    | Playing Business


type alias Model =
    { page : Page
    , remaining : List Transaction
    , selectedDebit : String
    , selectedCredit : String
    , enteredAmount : String
    , feedback : Maybe Bool
    , score : Int
    , total : Int
    , saved : Dict String SavedAnswer
    , missed : List Transaction
    }


type Msg
    = ChooseBusiness Business
    | BackToList
    | SelectDebit String
    | SelectCredit String
    | EnterAmount String
    | Submit
    | Next
    | Retry
    | ClearAll


txnKey : Business -> Transaction -> String
txnKey business txn =
    business.id ++ ":" ++ txn.date ++ ": " ++ txn.description


prefill : Business -> List Transaction -> Dict String SavedAnswer -> { debit : String, credit : String, amount : String }
prefill business remaining saved =
    case remaining of
        txn :: _ ->
            case Dict.get (txnKey business txn) saved of
                Just answer ->
                    answer

                Nothing ->
                    { debit = "", credit = "", amount = "" }

        [] ->
            { debit = "", credit = "", amount = "" }


init : Decode.Value -> ( Model, Cmd msg )
init flags =
    ( { page = ChoosingBusiness
      , remaining = []
      , selectedDebit = ""
      , selectedCredit = ""
      , enteredAmount = ""
      , feedback = Nothing
      , score = 0
      , total = 0
      , saved = decodeFlags flags
      , missed = []
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


startBusiness : Business -> Dict String SavedAnswer -> Model
startBusiness business saved =
    let
        remaining =
            business.transactions
                |> List.filter (\txn -> not (Dict.member (txnKey business txn) saved))

        fields =
            prefill business remaining saved
    in
    { page = Playing business
    , remaining = remaining
    , selectedDebit = fields.debit
    , selectedCredit = fields.credit
    , enteredAmount = fields.amount
    , feedback = Nothing
    , score = 0
    , total = 0
    , saved = saved
    , missed = []
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChooseBusiness business ->
            ( startBusiness business model.saved, Cmd.none )

        BackToList ->
            ( { page = ChoosingBusiness
              , remaining = []
              , selectedDebit = ""
              , selectedCredit = ""
              , enteredAmount = ""
              , feedback = Nothing
              , score = 0
              , total = 0
              , saved = model.saved
              , missed = []
              }
            , Cmd.none
            )

        SelectDebit val ->
            ( { model | selectedDebit = val }, Cmd.none )

        SelectCredit val ->
            ( { model | selectedCredit = val }, Cmd.none )

        EnterAmount val ->
            ( { model | enteredAmount = val }, Cmd.none )

        Submit ->
            case model.page of
                Playing business ->
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
                                                txnKey business txn

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
                                , missed =
                                    if correct then
                                        model.missed

                                    else
                                        model.missed ++ [ txn ]
                              }
                            , cmd
                            )

                        [] ->
                            ( model, Cmd.none )

                ChoosingBusiness ->
                    ( model, Cmd.none )

        Next ->
            case model.page of
                Playing business ->
                    case model.remaining of
                        _ :: rest ->
                            let
                                fields =
                                    prefill business rest model.saved
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

                ChoosingBusiness ->
                    ( model, Cmd.none )

        Retry ->
            case model.page of
                Playing business ->
                    let
                        fields =
                            prefill business model.missed model.saved
                    in
                    ( { model
                        | remaining = model.missed
                        , missed = []
                        , selectedDebit = fields.debit
                        , selectedCredit = fields.credit
                        , enteredAmount = fields.amount
                        , feedback = Nothing
                        , score = 0
                        , total = 0
                      }
                    , Cmd.none
                    )

                ChoosingBusiness ->
                    ( model, Cmd.none )

        ClearAll ->
            case model.page of
                Playing business ->
                    ( { model
                        | remaining = business.transactions
                        , selectedDebit = ""
                        , selectedCredit = ""
                        , enteredAmount = ""
                        , feedback = Nothing
                        , score = 0
                        , total = 0
                        , saved = Dict.empty
                        , missed = []
                      }
                    , clearAnswers ()
                    )

                ChoosingBusiness ->
                    ( model, Cmd.none )


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


accountName : List Account -> Int -> String
accountName accts number =
    accts
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


accountGroups : List Account -> List ( AccountType, List Account )
accountGroups accts =
    let
        types =
            [ Asset, ContraAsset, Liability, Equity, Revenue, Expense ]
    in
    List.filterMap
        (\t ->
            let
                matching =
                    List.filter (\a -> a.accountType == t) accts
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


accountSelect : List Account -> String -> (String -> Msg) -> String -> Html Msg
accountSelect accts lbl toMsg current =
    div [ class "field" ]
        [ label [] [ text lbl ]
        , select [ onInput toMsg ]
            (option [ value "", selected (current == "") ] [ text "-- pick --" ]
                :: List.map
                    (\( t, groupAccts ) ->
                        optgroup [ attribute "label" (accountTypeName t) ]
                            (List.map (accountOption current) groupAccts)
                    )
                    (accountGroups accts)
            )
        ]


progressBar : Business -> Model -> Html Msg
progressBar business model =
    let
        total =
            List.length business.transactions

        current =
            total - List.length model.remaining + 1
    in
    small [ class "progress" ]
        [ text (String.fromInt current ++ " / " ++ String.fromInt total) ]


view : Model -> Html Msg
view model =
    case model.page of
        ChoosingBusiness ->
            viewBusinessList model.saved

        Playing business ->
            viewGame business model


viewBusinessList : Dict String SavedAnswer -> Html Msg
viewBusinessList saved =
    div [ class "container" ]
        [ header []
            [ h1 [ class "title" ] [ text "Journal Entry Practice" ] ]
        , main_ []
            (List.map (viewBusinessCard saved) businesses)
        , footer []
            [ button [ class "btn btn-clear", onClick ClearAll ] [ text "Clear Correct Answers" ]
            ]
        ]


viewBusinessCard : Dict String SavedAnswer -> Business -> Html Msg
viewBusinessCard saved business =
    let
        completed =
            business.transactions
                |> List.filter (\txn -> Dict.member (txnKey business txn) saved)
                |> List.length

        total =
            List.length business.transactions
    in
    button [ class "card business-card", onClick (ChooseBusiness business) ]
        [ h2 [] [ text business.name ]
        , small []
            [ text
                (String.fromInt completed
                    ++ " / "
                    ++ String.fromInt total
                )
            ]
        ]


viewGame : Business -> Model -> Html Msg
viewGame business model =
    div [ class "container" ]
        [ header []
            [ button [ class "btn-back", onClick BackToList ] [ text "\u{2190} All Businesses" ]
            , h1 [ class "title" ] [ text business.name ]
            ]
        , main_ []
            [ case model.remaining of
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
                        , if List.isEmpty model.missed then
                            p [] [ text "Perfect score!" ]

                          else
                            button [ class "btn", onClick Retry ]
                                [ text
                                    ("Retry "
                                        ++ String.fromInt (List.length model.missed)
                                        ++ " missed"
                                    )
                                ]
                        ]

                txn :: _ ->
                    div [ class "card" ]
                        [ progressBar business model
                        , h2 [ class "description" ] [ text (txn.date ++ ": " ++ txn.description) ]
                        , case model.feedback of
                            Nothing ->
                                div [ class "form" ]
                                    [ accountSelect business.accounts "Debit" SelectDebit model.selectedDebit
                                    , accountSelect business.accounts "Credit" SelectCredit model.selectedCredit
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
                                        div [ class "answer" ]
                                            [ p []
                                                [ text "Debit: "
                                                , span [ class "answer-detail" ] [ text (accountName business.accounts txn.debitAccount) ]
                                                ]
                                            , p []
                                                [ text "Credit: "
                                                , span [ class "answer-detail" ] [ text (accountName business.accounts txn.creditAccount) ]
                                                ]
                                            , p []
                                                [ text "Amount: "
                                                , span [ class "answer-detail" ] [ text (formatCents txn.amount) ]
                                                ]
                                            ]

                                      else
                                        text ""
                                    , button [ class "btn", onClick Next ] [ text "Next" ]
                                    ]
                        ]
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
