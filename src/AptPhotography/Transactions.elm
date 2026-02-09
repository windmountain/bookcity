module AptPhotography.Transactions exposing (transactions)

import Transaction exposing (Transaction)


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner invests $30,000 cash to open Apt Photography"
        1010
        3010
        3000000
    , Transaction "Jan 2"
        "Purchased cameras, lenses, and lighting for $12,000 cash"
        1500
        1010
        1200000
    , Transaction "Jan 2"
        "Bought backdrops, props, and studio furniture for $4,000 cash"
        1510
        1010
        400000
    , Transaction "Jan 3"
        "Paid $1,800 for a one-year equipment insurance policy"
        1040
        1010
        180000
    , Transaction "Jan 3"
        "Ordered photo paper and ink on account from ShutterSupply for $800"
        1030
        2010
        80000
    , Transaction "Jan 5"
        "Received $1,500 in deposits for upcoming wedding shoots"
        1010
        2030
        150000
    , Transaction "Jan 7"
        "Earned $2,200 in portrait session fees this week"
        1010
        4010
        220000
    , Transaction "Jan 7"
        "Sold $350 in prints this week"
        1010
        4020
        35000
    , Transaction "Jan 10"
        "Paid January studio rent of $1,500"
        6020
        1010
        150000
    , Transaction "Jan 10"
        "Paid $400 for website advertising"
        6070
        1010
        40000
    , Transaction "Jan 14"
        "Earned $1,800 in session fees this week"
        1010
        4010
        180000
    , Transaction "Jan 14"
        "Sold $500 in prints this week"
        1010
        4020
        50000
    , Transaction "Jan 15"
        "Paid assistant $1,600 for the first half of January"
        6010
        1010
        160000
    , Transaction "Jan 18"
        "Paid ShutterSupply $800 for the Jan 3 order"
        2010
        1010
        80000
    , Transaction "Jan 18"
        "Shot a wedding and recognized $750 of the deposit as earned revenue"
        2030
        4010
        75000
    , Transaction "Jan 21"
        "Earned $2,000 in session fees this week"
        1010
        4010
        200000
    , Transaction "Jan 21"
        "Sold $280 in prints this week"
        1010
        4020
        28000
    , Transaction "Jan 25"
        "Paid $320 for travel to an on-location shoot"
        6080
        1010
        32000
    , Transaction "Jan 28"
        "Earned $1,600 in session fees this week"
        1010
        4010
        160000
    , Transaction "Jan 28"
        "Sold $400 in prints this week"
        1010
        4020
        40000
    , Transaction "Jan 31"
        "Paid assistant $1,600 for the second half of January"
        6010
        1010
        160000
    , Transaction "Jan 31"
        "Received $650 electric bill and paid it"
        6030
        1010
        65000
    , Transaction "Jan 31"
        "Recorded $200 depreciation on camera equipment"
        6050
        1505
        20000
    , Transaction "Jan 31"
        "Recorded $65 depreciation on studio furniture"
        6050
        1515
        6500
    , Transaction "Jan 31"
        "Recognized $150 of the prepaid insurance used this month"
        6040
        1040
        15000
    ]
