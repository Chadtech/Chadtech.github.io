module Components.Restaurant.Rating exposing (from)


import Html             exposing (..)
import Html.Attributes  exposing (..)
import Types            exposing (..)
import Components.Restaurant.Stars as Stars



from : Restaurant -> List (Html Msg)
from restaurant =
  List.concat
  [ [ starsCount restaurant.starsCount ]

  , Stars.from restaurant
  
  , [ reviewsCount restaurant.reviewsCount ]
  ]


starsCount : String -> Html Msg
starsCount count =
  p
  [ class "listing-rating" ]
  [ text count ]


reviewsCount : String -> Html Msg
reviewsCount count =
  p
  [ class "listing-reviews-count" ]
  [ text (formatReviewsCount count) ]

formatReviewsCount : String -> String
formatReviewsCount count =
  "(" ++ count ++ ") reviews"