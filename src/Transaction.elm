module Transaction exposing (Transaction)


type alias Transaction =
    { date : String
    , description : String
    , debitAccount : Int
    , creditAccount : Int
    , amount : Int -- cents
    }
