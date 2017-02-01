module Components.LeftBar.PaymentOptions exposing (render)


import Types exposing (Msg(..), Model, Restaurant)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Set



render : Model -> Html Msg
render model =
  div
  [ class "left-bar-section" ]
  (title :: toOptions model)



-- SUB COMPONENTS



toOptions : Model -> List (Html Msg)
toOptions model =
  List.map (option model) (getPaymentOptions model)


option : Model -> String -> Html Msg
option {paymentFilters, restaurants} paymentOption =  
  div 
  [ selectedClass (Set.member paymentOption paymentFilters) 
  , onClick (TogglePaymentFilter paymentOption)
  ]
  [ p 
    []
    [ text (trim paymentOption) ] 
  , p 
    [ class "option-count" ]
    [ restaurants
      |>countRestaurantsOf paymentOption
      |>toString
      |>text
    ] 
  ]


selectedClass : Bool -> Attribute Msg
selectedClass selected =
  if selected then
    class "left-bar-option selected"
  else
    class "left-bar-option"


title : Html Msg
title =
  p
  [ class "left-bar-header"]
  [ text "Payment Options" ]



-- UTIL



trim : String -> String
trim paymentOption =
  if String.length paymentOption > 16 then
    String.slice 0 16 paymentOption ++ ".."
  else 
    paymentOption


countRestaurantsOf : String -> List Restaurant -> Int
countRestaurantsOf paymentOption restaurants =
  List.foldr (addIf paymentOption) 0 restaurants


addIf : String -> Restaurant -> Int -> Int
addIf paymentOption {paymentOptions} count =
  if List.member paymentOption paymentOptions then
    count + 1
  else
    count


getPaymentOptions : Model -> List String
getPaymentOptions {restaurants} =
  List.map (.paymentOptions) restaurants
  |>List.concat
  |>Set.fromList
  |>Set.toList






