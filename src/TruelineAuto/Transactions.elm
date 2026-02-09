module TruelineAuto.Transactions exposing (transactions)

import Transaction exposing (Transaction)


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner invests $45,000 cash to open Trueline Auto"
        1010
        3010
        4500000
    , Transaction "Jan 2"
        "Purchased a hydraulic lift and compressor for $18,000 with a note"
        1500
        2500
        1800000
    , Transaction "Jan 2"
        "Bought diagnostic scanner and tools for $6,000 cash"
        1510
        1010
        600000
    , Transaction "Jan 3"
        "Paid $3,000 for a one-year garage insurance policy"
        1050
        1010
        300000
    , Transaction "Jan 3"
        "Ordered brake pads, filters, and oil on account from AutoParts Plus for $2,800"
        1030
        2010
        280000
    , Transaction "Jan 5"
        "Purchased shop rags, cleaners, and hand tools for $600 cash"
        1040
        1010
        60000
    , Transaction "Jan 7"
        "Earned $2,400 in labor fees this week"
        1010
        4010
        240000
    , Transaction "Jan 7"
        "Sold $1,600 in parts installed this week"
        1010
        4020
        160000
    , Transaction "Jan 10"
        "Paid January rent of $1,800"
        6020
        1010
        180000
    , Transaction "Jan 14"
        "Earned $2,900 in labor fees this week"
        1010
        4010
        290000
    , Transaction "Jan 14"
        "Sold $2,100 in parts installed this week"
        1010
        4020
        210000
    , Transaction "Jan 14"
        "Billed city fleet $1,200 for maintenance work on account"
        1020
        4010
        120000
    , Transaction "Jan 15"
        "Paid mechanics $4,800 for the first half of January"
        6010
        1010
        480000
    , Transaction "Jan 18"
        "Paid AutoParts Plus $2,800 for the Jan 3 order"
        2010
        1010
        280000
    , Transaction "Jan 21"
        "Earned $3,100 in labor fees this week"
        1010
        4010
        310000
    , Transaction "Jan 21"
        "Sold $1,900 in parts installed this week"
        1010
        4020
        190000
    , Transaction "Jan 22"
        "Ordered $2,400 of parts on account from AutoParts Plus"
        1030
        2010
        240000
    , Transaction "Jan 25"
        "Received $1,200 from city fleet for the Jan 14 invoice"
        1010
        1020
        120000
    , Transaction "Jan 28"
        "Earned $2,700 in labor fees this week"
        1010
        4010
        270000
    , Transaction "Jan 28"
        "Sold $1,800 in parts installed this week"
        1010
        4020
        180000
    , Transaction "Jan 31"
        "Paid mechanics $4,800 for the second half of January"
        6010
        1010
        480000
    , Transaction "Jan 31"
        "Received $1,100 electric and gas bill and paid it"
        6030
        1010
        110000
    , Transaction "Jan 31"
        "Paid $150 interest on the equipment note"
        6080
        1010
        15000
    , Transaction "Jan 31"
        "Recorded $300 depreciation on shop equipment"
        6050
        1505
        30000
    , Transaction "Jan 31"
        "Recorded $100 depreciation on diagnostic tools"
        6050
        1515
        10000
    , Transaction "Jan 31"
        "Recognized $250 of the prepaid insurance used this month"
        6040
        1050
        25000
    ]
