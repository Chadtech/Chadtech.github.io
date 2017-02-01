module View exposing (view)

import Html             exposing (..)
import Html.Attributes  exposing (class, placeholder, value)
import Html.Events      exposing (on, onInput, keyCode)
import Types            exposing (..)
{-
  Imports like Components.LeftBar.Cuisine
  are coming from Components/LeftBar/Cuisine.elm
-}
import Components.LeftBar.Cuisine as Cuisine
import Components.LeftBar.Rating as Rating
import Components.LeftBar.PaymentOptions as PaymentOptions
import Components.ListingArea as Listings

{-
    In React, JSX compiles to JS function such that..

      div( 
        { attributes },
        child element 0,
        child element 1,
        child element 2,
        ..
      )



    Elm is similar, but rather than using JSX, it 
    just uses plain ol' functions such that..

      div 
        [ list of attributes ] 
        [ list of children ]



    thus, a div with no attributes or children is
    written as ..

      div [] []
-}


-- VIEW


view : Model -> Html Msg
view model = 
  div
    [ class "main" ]
    [ searchBar model.searchBarField
    , leftBar model
    , Listings.render model
    ]


-- SECTIONS


leftBar : Model -> Html Msg
leftBar model =
  div
    [ class "left-bar" ]
    [ Cuisine.render model
    , Rating.render
    , PaymentOptions.render model
    , div [ class "left-bar-footer" ] []
    ]


searchBar : String -> Html Msg
searchBar searchBarField = 
  div
    [ class "search-bar-container" ]
    [ input
      [ class "search-bar" 
      , placeholder "Search for Restaurants by Name, Cuisine, Location"
      , onInput SearchBarUpdate
      , value searchBarField
      ]
      []
    ]




