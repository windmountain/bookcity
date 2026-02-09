module SterlingBakery.Transactions exposing (transactions)

import Transaction exposing (Transaction)


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner invests $50,000 cash to open Sterling Bakery"
        1010
        3010
        5000000
    , Transaction "Jan 2"
        "Purchased commercial oven and mixer with a $15,000 note"
        1500
        2500
        1500000
    , Transaction "Jan 2"
        "Bought display cases for $3,000 cash"
        1510
        1010
        300000
    , Transaction "Jan 3"
        "Paid January rent of $2,000"
        6020
        1010
        200000
    , Transaction "Jan 3"
        "Ordered flour, sugar, and butter on account from Valley Foods for $1,800"
        1030
        2010
        180000
    , Transaction "Jan 7"
        "Bakery sales this week totaled $2,600"
        1010
        4010
        260000
    , Transaction "Jan 7"
        "Sold $400 worth of rolls to Main Street Deli on account"
        1020
        4020
        40000
    , Transaction "Jan 10"
        "Paid $350 for a newspaper ad"
        6050
        1010
        35000
    , Transaction "Jan 14"
        "Bakery sales this week totaled $3,100"
        1010
        4010
        310000
    , Transaction "Jan 14"
        "Sold $400 worth of bread to Main Street Deli on account"
        1020
        4020
        40000
    , Transaction "Jan 15"
        "Paid employees $2,800 for the first half of January"
        6010
        1010
        280000
    , Transaction "Jan 18"
        "Paid Valley Foods $1,800 for the Jan 3 order"
        2010
        1010
        180000
    , Transaction "Jan 18"
        "Received $400 from Main Street Deli for the Jan 7 invoice"
        1010
        1020
        40000
    , Transaction "Jan 21"
        "Bakery sales this week totaled $3,400"
        1010
        4010
        340000
    , Transaction "Jan 21"
        "Sold $500 worth of pastries to Main Street Deli on account"
        1020
        4020
        50000
    , Transaction "Jan 25"
        "Ordered $1,600 of supplies from Valley Foods on account"
        1030
        2010
        160000
    , Transaction "Jan 28"
        "Bakery sales this week totaled $2,900"
        1010
        4010
        290000
    , Transaction "Jan 28"
        "Owner withdrew $1,000 for personal use"
        3020
        1010
        100000
    , Transaction "Jan 31"
        "Paid employees $2,800 for the second half of January"
        6010
        1010
        280000
    , Transaction "Jan 31"
        "Received $900 electric and gas bill and paid it"
        6030
        1010
        90000
    , Transaction "Jan 31"
        "Paid $125 interest on the equipment note"
        6060
        1010
        12500
    , Transaction "Jan 31"
        "Recorded $250 depreciation on baking equipment"
        6040
        1505
        25000
    , Transaction "Jan 31"
        "Recorded $50 depreciation on display cases"
        6040
        1515
        5000
    ]
