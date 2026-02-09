module FaithfulVet.ChartOfAccounts exposing (accounts)

import Account exposing (Account, AccountType(..))


accounts : List Account
accounts =
    -- Assets
    [ Account 1010 "Cash" Asset
    , Account 1020 "Accounts Receivable" Asset
    , Account 1030 "Medical Supplies" Asset
    , Account 1040 "Prepaid Insurance" Asset
    , Account 1500 "Medical Equipment" Asset
    , Account 1505 "Accum. Depreciation - Medical Equipment" ContraAsset
    , Account 1510 "Office Furniture" Asset
    , Account 1515 "Accum. Depreciation - Office Furniture" ContraAsset

    -- Liabilities
    , Account 2010 "Accounts Payable" Liability
    , Account 2020 "Wages Payable" Liability
    , Account 2030 "Unearned Revenue" Liability
    , Account 2500 "Note Payable" Liability

    -- Owner's Equity
    , Account 3010 "Owner's Capital" Equity
    , Account 3020 "Owner's Draws" Equity

    -- Revenue
    , Account 4010 "Veterinary Service Revenue" Revenue
    , Account 4020 "Pharmacy Revenue" Revenue

    -- Operating Expenses
    , Account 6010 "Wages Expense" Expense
    , Account 6020 "Rent Expense" Expense
    , Account 6030 "Utilities Expense" Expense
    , Account 6040 "Insurance Expense" Expense
    , Account 6050 "Depreciation Expense" Expense
    , Account 6060 "Medical Supplies Expense" Expense
    , Account 6070 "Interest Expense" Expense
    ]
