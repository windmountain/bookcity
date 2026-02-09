module KeystoneLanes.Transactions exposing (Transaction, transactions)


type alias Transaction =
    { date : String
    , description : String
    , debitAccount : Int
    , creditAccount : Int
    , amount : Int -- cents
    }


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner puts up $150,000 in cash to open Keystone Lanes"
        1010
        3010
        15000000
    , Transaction "Jan 1"
        "Took out a $300,000 mortgage to buy the building on Elm Street"
        1500
        2500
        30000000
    , Transaction "Jan 2"
        "Paid cash for lanes, pinsetters, and ball returns for $85,000"
        1510
        1010
        8500000
    , Transaction "Jan 3"
        "Paid $12,000 for a one-year property insurance policy"
        1040
        1010
        1200000
    , Transaction "Jan 5"
        "Ordered $2,400 worth of lane oil, rental shoes, and pins on account from BowlCo Supply"
        1030
        2010
        240000
    , Transaction "Jan 7"
        "Earned $3,200 in lane rentals this week"
        1010
        4010
        320000
    , Transaction "Jan 7"
        "Earned $640 in shoe rentals this week"
        1010
        4020
        64000
    , Transaction "Jan 10"
        "Paid $450 for an ad in the Greenfield Gazette"
        6080
        1010
        45000
    , Transaction "Jan 14"
        "Earned $3,800 in lane rentals this week"
        1010
        4010
        380000
    , Transaction "Jan 14"
        "Earned $760 in shoe rentals this week"
        1010
        4020
        76000
    , Transaction "Jan 15"
        "Paid employees $4,200 for the first half of January"
        6010
        1010
        420000
    , Transaction "Jan 18"
        "Sent $2,400 check to BowlCo Supply for the Jan 5 order"
        2010
        1010
        240000
    , Transaction "Jan 21"
        "Earned $4,100 in lane rentals this week"
        1010
        4010
        410000
    , Transaction "Jan 21"
        "Earned $820 in shoe rentals this week"
        1010
        4020
        82000
    , Transaction "Jan 28"
        "Earned $3,500 in lane rentals this week"
        1010
        4010
        350000
    , Transaction "Jan 28"
        "Earned $700 in shoe rentals this week"
        1010
        4020
        70000
    , Transaction "Jan 31"
        "Paid employees $4,200 for the second half of January"
        6010
        1010
        420000
    , Transaction "Jan 31"
        "Received a $1,800 electric and gas bill and paid it"
        6040
        1010
        180000
    , Transaction "Jan 31"
        "Paid $1,250 in interest on the mortgage this month"
        6090
        1010
        125000
    , Transaction "Jan 31"
        "Paid $550 toward the mortgage principal this month"
        2500
        1010
        55000
    , Transaction "Jan 31"
        "Recorded $750 in monthly depreciation on the building"
        6060
        1505
        75000
    , Transaction "Jan 31"
        "Recorded $1,415 in monthly depreciation on bowling equipment"
        6060
        1515
        141500
    , Transaction "Jan 31"
        "Recognized $1,000 of the prepaid insurance used this month"
        6050
        1040
        100000
    ]
