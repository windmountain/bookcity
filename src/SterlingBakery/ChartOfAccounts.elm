module SterlingBakery.ChartOfAccounts exposing (accounts)

import Account exposing (Account, AccountType(..))


accounts : List Account
accounts =
    -- Assets
    [ Account 1010 "Cash" Asset
    , Account 1020 "Accounts Receivable" Asset
    , Account 1030 "Baking Supplies" Asset
    , Account 1500 "Baking Equipment" Asset
    , Account 1505 "Accum. Depreciation - Baking Equipment" ContraAsset
    , Account 1510 "Display Cases" Asset
    , Account 1515 "Accum. Depreciation - Display Cases" ContraAsset

    -- Liabilities
    , Account 2010 "Accounts Payable" Liability
    , Account 2020 "Wages Payable" Liability
    , Account 2500 "Note Payable" Liability

    -- Owner's Equity
    , Account 3010 "Owner's Capital" Equity
    , Account 3020 "Owner's Draws" Equity

    -- Revenue
    , Account 4010 "Bakery Sales Revenue" Revenue
    , Account 4020 "Wholesale Revenue" Revenue

    -- Operating Expenses
    , Account 6010 "Wages Expense" Expense
    , Account 6020 "Rent Expense" Expense
    , Account 6030 "Utilities Expense" Expense
    , Account 6040 "Depreciation Expense" Expense
    , Account 6050 "Advertising Expense" Expense
    , Account 6060 "Interest Expense" Expense
    ]
