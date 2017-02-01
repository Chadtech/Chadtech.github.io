module Components.Restaurant.Count exposing (from)



import Html             exposing (..)
import Html.Attributes  exposing (..)
import Html.Events exposing (onClick)
import Types            exposing (..)



from : Model -> Html Msg
from {searchTime, restaurants} =
  div
    [ class "listings-count-container" ]
    [ countView restaurants
    , timeView searchTime
    , div 
        [ class "horizontal-gray-bar" ]
        []
    ]


-- SUB COMPONENTS


timeView : Float -> Html Msg
timeView time =
  p
    [ class "listings-time" ]
    [ text (formatTime time) ]


countView : List Restaurant -> Html Msg
countView restaurants =
  p
    [ class "listings-count" ]
    [ toCount restaurants  ]



-- UTIL


toCount : List Restaurant -> Html Msg
toCount =
  List.length >> formatCount >> text


formatTime : Float -> String
formatTime time =
  " in " ++ (toString time) ++ " seconds"


formatCount : Int -> String
formatCount numberOfRestaurants =
  (toString numberOfRestaurants) ++ " results found" 


