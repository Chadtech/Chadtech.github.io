module Components.Restaurant.Listing exposing (from)


import Components.Restaurant.Rating as Ratings
import Array
import Html             exposing (..)
import Html.Attributes  exposing (..)
import Html.Events exposing (onClick)
import Types            exposing (..)



from : Restaurant -> Html Msg
from restaurant =
  div 
  [ class "listing" ]
  [ pic restaurant.imageUrl
  , listingBody restaurant
  ]


listingBody : Restaurant -> Html Msg
listingBody restaurant =
  div
  [ class "listing-body" ]
  [ listingName restaurant.name

  , div
    [ class "listing-ratings" ]
    (Ratings.from restaurant)

  , div 
    [ class "listing-info-container" ]
    [ p
      [ class "listing-info" ]
      [ text (formatInfo restaurant) ]
    ]
  ]


listingName : String -> Html Msg
listingName name =
  p 
  [ class "listing-name" ]
  [ text name ]



pic : String -> Html Msg
pic url =
  div
  [ style 
    [ ("background", formatUrl url)]
  , class "listing-image"
  ]
  []


-- UTIL


formatUrl : String -> String
formatUrl url =
  "url(" ++ url ++ ") 50% 50% no-repeat"


formatInfo : Restaurant -> String
formatInfo {foodType, neighborhood, priceRange} =
  foodType ++ " | " ++ neighborhood ++ " | " ++ priceRange

