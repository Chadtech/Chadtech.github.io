module Components.ListingArea exposing (render)


import Html             exposing (..)
import Html.Attributes  exposing (..)
import Types            exposing (..)
import Components.Restaurant.Listings as Listings




render : Model -> Html Msg
render model =
  if List.isEmpty model.restaurants then
    div 
      [ class "restaurants-listings" ]
      []
  else
    div 
      [ class "restaurants-listings" ]
      (Listings.from model)





