module Types exposing (..)


import Set exposing (Set)


{-
  This is every possible action
  that can happen in this app.
-}
type Msg 
  = SearchBarUpdate String
  | ToggleCuisineFilter String
  | TogglePaymentFilter String
  | GetSearchResults (List String)
  | GetSearchTime Float
  | ShowMore


{-
  This is the model of the entire app,
  and is roughly equivalent to a react
  state.
-}
type alias Model =
  { searchBarField : String 
  , searchTime : Float
  , restaurants : List Restaurant
  , cuisineFilters : Set String
  , paymentFilters : Set String
  , showMore : Bool
  }


type alias Restaurant =
  { address : String
  , area : String
  , city : String
  , country : String
  , diningStyle : String
  , foodType : String
  , id : String
  , imageUrl : String
  , mobileReserveUrl : String
  , name : String
  , neighborhood : String
  , paymentOptions : List String
  , phone : String
  , phoneNumber : String
  , postalCode : String
  , price : Int
  , priceRange : String
  , reserveUrl : String
  , reviewsCount : String
  , starsCount : String
  , state : String
  }


