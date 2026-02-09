module AptPhotography.ChartOfAccounts exposing (accounts)

import Account exposing (Account, AccountType(..))


accounts : List Account
accounts =
    -- Assets
    [ Account 1010 "Cash" Asset
    , Account 1020 "Accounts Receivable" Asset
    , Account 1030 "Photography Supplies" Asset
    , Account 1040 "Prepaid Insurance" Asset
    , Account 1500 "Camera Equipment" Asset
    , Account 1505 "Accum. Depreciation - Camera Equipment" ContraAsset
    , Account 1510 "Studio Furniture" Asset
    , Account 1515 "Accum. Depreciation - Studio Furniture" ContraAsset

    -- Liabilities
    , Account 2010 "Accounts Payable" Liability
    , Account 2020 "Wages Payable" Liability
    , Account 2030 "Unearned Revenue" Liability

    -- Owner's Equity
    , Account 3010 "Owner's Capital" Equity
    , Account 3020 "Owner's Draws" Equity

    -- Revenue
    , Account 4010 "Session Revenue" Revenue
    , Account 4020 "Print Sales Revenue" Revenue

    -- Operating Expenses
    , Account 6010 "Wages Expense" Expense
    , Account 6020 "Rent Expense" Expense
    , Account 6030 "Utilities Expense" Expense
    , Account 6040 "Insurance Expense" Expense
    , Account 6050 "Depreciation Expense" Expense
    , Account 6060 "Supplies Expense" Expense
    , Account 6070 "Advertising Expense" Expense
    , Account 6080 "Travel Expense" Expense
    ]
