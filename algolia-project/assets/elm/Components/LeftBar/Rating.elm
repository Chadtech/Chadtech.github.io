module Components.LeftBar.Rating exposing (render, star, emptyStar)


import Types exposing (Msg(..), Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)




render : Html Msg
render =
  div 
  [ class "left-bar-section" ]
  (title :: List.map row (List.range 0 5))




title : Html Msg
title =
  p
  [ class "left-bar-header"]
  [ text "Rating" ]


row : Int -> Html Msg
row numberOfStars =
  div 
  [ class "star-row" ]
  (getStars numberOfStars)


getStars : Int -> List (Html Msg)
getStars numberOfStars =
  List.append 
    (List.repeat numberOfStars star)
    (List.repeat (5 - numberOfStars) emptyStar)


star : Html Msg 
star =
  img 
  [ class "star"
  , src "assets/images/star-plain.png" ]
  []


emptyStar : Html Msg 
emptyStar =
  img 
  [ class "star"
  , src "assets/images/star-empty.png" ]
  []


