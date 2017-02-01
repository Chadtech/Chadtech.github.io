module Components.Restaurant.Stars exposing (from)


import Html            exposing (..)
import Html.Attributes exposing (..)
import Types           exposing (..)


from : Restaurant -> List (Html Msg)
from restaurant =
  let
    numberOfStars =
      case String.toFloat restaurant.starsCount of
        Ok val ->
          round val

        Err _ ->
          0
  in
    List.append 
      (List.repeat numberOfStars star)
      (List.repeat (5 - numberOfStars) emptyStar)


star : Html Msg 
star =
  img 
  [ class "listing-star"
  , src "assets/images/star-plain.png" ]
  []


emptyStar : Html Msg 
emptyStar =
  img 
  [ class "listing-star"
  , src "assets/images/star-empty.png" ]
  []