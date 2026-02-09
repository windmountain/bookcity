module SoundFitness.ChartOfAccounts exposing (accounts)

import Account exposing (Account, AccountType(..))


accounts : List Account
accounts =
    -- Assets
    [ Account 1010 "Cash" Asset
    , Account 1020 "Accounts Receivable" Asset
    , Account 1030 "Gym Supplies" Asset
    , Account 1040 "Prepaid Insurance" Asset
    , Account 1500 "Fitness Equipment" Asset
    , Account 1505 "Accum. Depreciation - Fitness Equipment" ContraAsset
    , Account 1510 "Leasehold Improvements" Asset
    , Account 1515 "Accum. Depreciation - Leasehold Improvements" ContraAsset

    -- Liabilities
    , Account 2010 "Accounts Payable" Liability
    , Account 2020 "Wages Payable" Liability
    , Account 2030 "Unearned Membership Revenue" Liability
    , Account 2500 "Note Payable" Liability

    -- Owner's Equity
    , Account 3010 "Owner's Capital" Equity
    , Account 3020 "Owner's Draws" Equity

    -- Revenue
    , Account 4010 "Membership Revenue" Revenue
    , Account 4020 "Personal Training Revenue" Revenue

    -- Operating Expenses
    , Account 6010 "Wages Expense" Expense
    , Account 6020 "Rent Expense" Expense
    , Account 6030 "Utilities Expense" Expense
    , Account 6040 "Insurance Expense" Expense
    , Account 6050 "Depreciation Expense" Expense
    , Account 6060 "Supplies Expense" Expense
    , Account 6070 "Advertising Expense" Expense
    , Account 6080 "Interest Expense" Expense
    ]
