module Update exposing (update)


import Types exposing (Model, Msg(..), Restaurant)
import Util.Restaurants as Restaurant
import Json.Decode as Json
import Set
import Ports exposing (..)



update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  {-
    This is kind of like a swtich statement,
    except that it covers every possible
    value of 'message' of type Msg. Every 
    possible value of Msg is defined 
    in Types.elm.
  -}
  case message of 
    SearchBarUpdate str ->
      if str == "" then
        onEmptyString model ! [ search str ]  
      else
        updateSearchBar str model ! [ search str ]

    ToggleCuisineFilter cuisine ->
      if Set.member cuisine model.cuisineFilters then
        { model
        | cuisineFilters =
            Set.remove cuisine model.cuisineFilters
        } ! []
      else
        { model
        | cuisineFilters =
            Set.insert cuisine model.cuisineFilters
        } ! []

    TogglePaymentFilter paymentOption ->
      if Set.member paymentOption model.paymentFilters then
        { model
        | paymentFilters =
            Set.remove paymentOption model.paymentFilters
        } ! []
      else 
        { model
        | paymentFilters =
            Set.insert paymentOption model.paymentFilters
        } ! []

    GetSearchResults results ->
      { model
      | restaurants = (decode results)
      } ! []

    GetSearchTime time ->
      { model
      | searchTime = time
      } ! []

    ShowMore ->
      { model
      | showMore = True
      } ! []



-- SEARCH BAR UPDATE


onEmptyString : Model -> Model
onEmptyString =
  clearFiltersAndRestaurants << updateSearchBar ""


clearFiltersAndRestaurants : Model -> Model
clearFiltersAndRestaurants model =
  { model
  | restaurants = []
  , cuisineFilters = Set.empty
  }

updateSearchBar : String -> Model -> Model
updateSearchBar str model =
  { model 
  | searchBarField = str
  , showMore = False
  } 



-- GET SEARCH RESULTS



decode : List String -> List Restaurant
decode =
  List.foldr decodeResult []


decodeResult : String -> List Restaurant -> List Restaurant
decodeResult str restaurants =
  case Json.decodeString Restaurant.decoder str of
    Ok result ->
      result :: restaurants
    Err _ ->
      restaurants
