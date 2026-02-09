module KeystoneLanes.ChartOfAccounts exposing (Account, AccountType(..), accounts)


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


accounts : List Account
accounts =
    -- Assets
    [ Account 1010 "Cash" Asset
    , Account 1020 "Accounts Receivable" Asset
    , Account 1030 "Supplies - Bowling" Asset
    , Account 1040 "Prepaid Insurance" Asset
    , Account 1500 "Building" Asset
    , Account 1505 "Accum. Depreciation - Building" ContraAsset
    , Account 1510 "Bowling Equipment" Asset
    , Account 1515 "Accum. Depreciation - Bowling Equipment" ContraAsset

    -- Liabilities
    , Account 2010 "Accounts Payable" Liability
    , Account 2020 "Wages Payable" Liability
    , Account 2030 "Sales Tax Payable" Liability
    , Account 2040 "Interest Payable" Liability
    , Account 2500 "Mortgage Payable" Liability

    -- Owner's Equity
    , Account 3010 "Owner's Capital" Equity
    , Account 3020 "Owner's Draws" Equity

    -- Revenue
    , Account 4010 "Lane Rental Revenue" Revenue
    , Account 4020 "Shoe Rental Revenue" Revenue

    -- Operating Expenses
    , Account 6010 "Wages Expense" Expense
    , Account 6020 "Payroll Tax Expense" Expense
    , Account 6030 "Rent Expense" Expense
    , Account 6040 "Utilities Expense" Expense
    , Account 6050 "Insurance Expense" Expense
    , Account 6060 "Depreciation Expense" Expense
    , Account 6070 "Maintenance & Supplies Expense" Expense
    , Account 6080 "Advertising Expense" Expense
    , Account 6090 "Interest Expense" Expense
    ]
