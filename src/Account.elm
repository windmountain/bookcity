module Account exposing (Account, AccountType(..))


type AccountType
    = Asset
    | ContraAsset
    | Liability
    | Equity
    | Revenue
    | Expense


type alias Account =
    { number : Int
    , name : String
    , accountType : AccountType
    }
