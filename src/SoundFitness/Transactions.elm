module SoundFitness.Transactions exposing (transactions)

import Transaction exposing (Transaction)


transactions : List Transaction
transactions =
    [ Transaction "Jan 1"
        "Owner invests $60,000 cash to open Sound Fitness"
        1010
        3010
        6000000
    , Transaction "Jan 1"
        "Took out a $40,000 note to buy treadmills, weights, and machines"
        1500
        2500
        4000000
    , Transaction "Jan 2"
        "Spent $12,000 cash on leasehold improvements: mirrors, flooring, and paint"
        1510
        1010
        1200000
    , Transaction "Jan 3"
        "Paid $3,600 for a one-year liability insurance policy"
        1040
        1010
        360000
    , Transaction "Jan 3"
        "Ordered towels, cleaning supplies, and mats on account for $900"
        1030
        2010
        90000
    , Transaction "Jan 5"
        "Collected $8,400 in January membership dues"
        1010
        4010
        840000
    , Transaction "Jan 5"
        "Collected $3,600 in prepaid quarterly memberships (Feb\u{2013}Mar portion)"
        1010
        2030
        360000
    , Transaction "Jan 7"
        "Earned $1,200 in personal training fees this week"
        1010
        4020
        120000
    , Transaction "Jan 10"
        "Paid $500 for social media advertising"
        6070
        1010
        50000
    , Transaction "Jan 10"
        "Paid January rent of $3,000"
        6020
        1010
        300000
    , Transaction "Jan 14"
        "Earned $1,400 in personal training fees this week"
        1010
        4020
        140000
    , Transaction "Jan 15"
        "Paid trainers and front desk staff $4,500 for the first half of January"
        6010
        1010
        450000
    , Transaction "Jan 18"
        "Paid $900 to the supply vendor for the Jan 3 order"
        2010
        1010
        90000
    , Transaction "Jan 21"
        "Earned $1,100 in personal training fees this week"
        1010
        4020
        110000
    , Transaction "Jan 28"
        "Earned $1,300 in personal training fees this week"
        1010
        4020
        130000
    , Transaction "Jan 31"
        "Paid trainers and front desk staff $4,500 for the second half of January"
        6010
        1010
        450000
    , Transaction "Jan 31"
        "Received $2,200 electric and water bill and paid it"
        6030
        1010
        220000
    , Transaction "Jan 31"
        "Paid $335 interest on the equipment note"
        6080
        1010
        33500
    , Transaction "Jan 31"
        "Recognized $1,800 of the prepaid quarterly memberships earned this month"
        2030
        4010
        180000
    , Transaction "Jan 31"
        "Recorded $670 depreciation on fitness equipment"
        6050
        1505
        67000
    , Transaction "Jan 31"
        "Recorded $200 depreciation on leasehold improvements"
        6050
        1515
        20000
    , Transaction "Jan 31"
        "Recognized $300 of the prepaid insurance used this month"
        6040
        1040
        30000
    ]
