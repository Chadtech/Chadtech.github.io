module Components.Restaurant.Listings exposing (from)


import Array
import Html             exposing (..)
import Html.Attributes  exposing (..)
import Html.Events exposing (onClick)
import Types            exposing (..)
import Set exposing (Set)
import Components.Restaurant.Listing as Listing
import Components.Restaurant.Count as Count



from : Model -> List (Html Msg)
from model =
  List.concat
  [ [ Count.from model ]
  , toListings model
  , [ showMore model.showMore
    , div [ class "main-area-footer" ] [] 
    ]
  ]



toListings : Model -> List (Html Msg)
toListings {showMore, cuisineFilters, restaurants} =
  if Set.isEmpty cuisineFilters then
    toListingsHelper showMore restaurants

  else
    List.filter (notIn cuisineFilters) restaurants
    |>toListingsHelper showMore


toListingsHelper : Bool -> List Restaurant -> List (Html Msg)
toListingsHelper show restaurants =
  if show || List.length restaurants < 3 then
    List.map Listing.from restaurants

  else
    List.map Listing.from (slice restaurants)



-- SUB COMPONENTS


showMoreButton : Html Msg
showMoreButton =
  input
  [ class "show-more-button"
  , type_ "submit" 
  , value "Show More"
  , onClick ShowMore
  ]
  []



-- UTIL


notIn : Set String -> Restaurant -> Bool
notIn filter {foodType} =
  Set.member foodType filter 


slice : List Restaurant -> List Restaurant
slice =
  Array.fromList >> Array.slice 0 3 >> Array.toList


showMore : Bool -> Html Msg
showMore show =
  if show then
    text ""
  else
    showMoreButton

