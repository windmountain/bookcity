module FaithfulVet.Transactions exposing (transactions)

import Transaction exposing (Transaction)


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner invests $80,000 cash to open Faithful Veterinary Clinic"
        1010
        3010
        8000000
    , Transaction "Jan 2"
        "Purchased X-ray machine and surgical tools for $35,000 with a note"
        1500
        2500
        3500000
    , Transaction "Jan 2"
        "Bought exam tables and office furniture for $5,000 cash"
        1510
        1010
        500000
    , Transaction "Jan 3"
        "Paid $6,000 for a one-year malpractice insurance policy"
        1040
        1010
        600000
    , Transaction "Jan 3"
        "Ordered vaccines and medications on account from VetSupply Co for $2,200"
        1030
        2010
        220000
    , Transaction "Jan 5"
        "Received $1,200 in prepaid wellness plan fees from pet owners"
        1010
        2030
        120000
    , Transaction "Jan 7"
        "Earned $3,600 in exam and treatment fees this week"
        1010
        4010
        360000
    , Transaction "Jan 7"
        "Sold $480 in medications this week"
        1010
        4020
        48000
    , Transaction "Jan 10"
        "Paid January rent of $2,500"
        6020
        1010
        250000
    , Transaction "Jan 14"
        "Earned $4,200 in exam and treatment fees this week"
        1010
        4010
        420000
    , Transaction "Jan 14"
        "Sold $560 in medications this week"
        1010
        4020
        56000
    , Transaction "Jan 15"
        "Paid veterinary technicians $5,200 for the first half of January"
        6010
        1010
        520000
    , Transaction "Jan 18"
        "Paid VetSupply Co $2,200 for the Jan 3 order"
        2010
        1010
        220000
    , Transaction "Jan 21"
        "Earned $3,800 in exam and treatment fees this week"
        1010
        4010
        380000
    , Transaction "Jan 21"
        "Sold $420 in medications this week"
        1010
        4020
        42000
    , Transaction "Jan 25"
        "Ordered $1,900 of medical supplies on account from VetSupply Co"
        1030
        2010
        190000
    , Transaction "Jan 28"
        "Earned $4,000 in exam and treatment fees this week"
        1010
        4010
        400000
    , Transaction "Jan 28"
        "Sold $500 in medications this week"
        1010
        4020
        50000
    , Transaction "Jan 31"
        "Paid veterinary technicians $5,200 for the second half of January"
        6010
        1010
        520000
    , Transaction "Jan 31"
        "Received $1,400 electric and gas bill and paid it"
        6030
        1010
        140000
    , Transaction "Jan 31"
        "Paid $290 interest on the equipment note"
        6070
        1010
        29000
    , Transaction "Jan 31"
        "Recognized $400 of prepaid wellness plan revenue earned this month"
        2030
        4010
        40000
    , Transaction "Jan 31"
        "Recorded $585 depreciation on medical equipment"
        6050
        1505
        58500
    , Transaction "Jan 31"
        "Recorded $85 depreciation on office furniture"
        6050
        1515
        8500
    , Transaction "Jan 31"
        "Recognized $500 of the prepaid insurance used this month"
        6040
        1040
        50000
    ]
