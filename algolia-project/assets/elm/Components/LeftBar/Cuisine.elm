module Components.LeftBar.Cuisine exposing (render)


import Types exposing (Msg(..), Model, Restaurant)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Set exposing (Set)




render : Model -> Html Msg
render model =
  div 
  [ class "left-bar-section" ]
  (title :: toOptions model)



-- SUB COMPONENTS



toOptions : Model -> List (Html Msg)
toOptions model =
  List.map (option model) (getCuisines model)


option : Model -> (Int, String) -> Html Msg
option {cuisineFilters, restaurants} (count, cuisine) =  
  div 
  [ selectedClass cuisine cuisineFilters
  , onClick (ToggleCuisineFilter cuisine)
  ]
  [ p 
    []
    [ text (trim cuisine) ]
  , p
    [ class "option-count" ]
    [ text (toString count)
    ] 
  ]


selectedClass : String -> Set String -> Attribute Msg
selectedClass cuisine filters =
  if Set.member cuisine filters then
    class "left-bar-option selected"
  else
    class "left-bar-option"


title : Html Msg
title =
  p
  [ class "left-bar-header"]
  [ text "Cuisine/Food Type" ]



-- UTIL



trim : String -> String
trim cuisine =
  if String.length cuisine > 16 then
    String.slice 0 16 cuisine ++ ".."
  else cuisine


getCuisines : Model -> List (Int, String)
getCuisines {restaurants} =
  List.foldr 
    (Set.insert << .foodType) 
    Set.empty 
    restaurants
  |>Set.toList
  |>List.map (pairWithCount restaurants)
  |>List.sortBy (Tuple.first)
  |>List.reverse


pairWithCount : List Restaurant -> String -> (Int, String)
pairWithCount restaurants cuisine =
  (countRestaurantsOf cuisine restaurants, cuisine)


countRestaurantsOf : String -> List Restaurant -> Int
countRestaurantsOf cuisine restaurants =
  List.foldr (addIf cuisine) 0 restaurants


addIf : String -> Restaurant -> Int -> Int
addIf cuisine restaurant count =
  if cuisine == restaurant.foodType then
    count + 1
  else
    count




