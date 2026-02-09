module UprightLandscaping.Transactions exposing (transactions)

import Transaction exposing (Transaction)


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner invests $35,000 cash to start Upright Landscaping"
        1010
        3010
        3500000
    , Transaction "Jan 2"
        "Purchased a used truck for $22,000 with a note"
        1500
        2500
        2200000
    , Transaction "Jan 2"
        "Bought mowers, trimmers, and a snow plow for $8,000 cash"
        1510
        1010
        800000
    , Transaction "Jan 3"
        "Paid $2,400 for a one-year commercial vehicle insurance policy"
        1040
        1010
        240000
    , Transaction "Jan 5"
        "Purchased salt, sand, and fuel on account for $1,100"
        1030
        2010
        110000
    , Transaction "Jan 6"
        "Plowed driveways and parking lots after a storm, earned $2,800 cash"
        1010
        4020
        280000
    , Transaction "Jan 7"
        "Billed Elm Court Condos $1,500 for snow removal contract"
        1020
        4020
        150000
    , Transaction "Jan 10"
        "Paid $250 for a flyer distribution"
        6070
        1010
        25000
    , Transaction "Jan 12"
        "Plowed after another storm, earned $2,400 cash"
        1010
        4020
        240000
    , Transaction "Jan 13"
        "Billed Elm Court Condos $1,500 for snow removal"
        1020
        4020
        150000
    , Transaction "Jan 15"
        "Paid workers $3,200 for the first half of January"
        6010
        1010
        320000
    , Transaction "Jan 15"
        "Received $1,500 from Elm Court Condos for the Jan 7 invoice"
        1010
        1020
        150000
    , Transaction "Jan 18"
        "Paid the supplier $1,100 for the Jan 5 order"
        2010
        1010
        110000
    , Transaction "Jan 20"
        "Earned $600 cash for winter pruning work"
        1010
        4010
        60000
    , Transaction "Jan 22"
        "Purchased $800 of supplies on account"
        1030
        2010
        80000
    , Transaction "Jan 24"
        "Plowed after a storm, earned $2,200 cash"
        1010
        4020
        220000
    , Transaction "Jan 25"
        "Billed Elm Court Condos $1,500 for snow removal"
        1020
        4020
        150000
    , Transaction "Jan 25"
        "Owner withdrew $800 for personal use"
        3020
        1010
        80000
    , Transaction "Jan 28"
        "Received $1,500 from Elm Court Condos for the Jan 13 invoice"
        1010
        1020
        150000
    , Transaction "Jan 31"
        "Paid workers $3,200 for the second half of January"
        6010
        1010
        320000
    , Transaction "Jan 31"
        "Paid $380 for gas and diesel fuel this month"
        6020
        1010
        38000
    , Transaction "Jan 31"
        "Paid $185 interest on the truck note"
        6080
        1010
        18500
    , Transaction "Jan 31"
        "Recorded $365 depreciation on the truck"
        6050
        1505
        36500
    , Transaction "Jan 31"
        "Recorded $135 depreciation on equipment"
        6050
        1515
        13500
    , Transaction "Jan 31"
        "Recognized $200 of the prepaid insurance used this month"
        6040
        1040
        20000
    ]
