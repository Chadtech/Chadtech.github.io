module Main exposing (..)


import Html
import Types exposing (Model, Msg(..), Restaurant)
import Ports exposing (..)
import View  exposing (view)
import Update exposing (update)
import Set



-- MAIN


main =
  Html.program
  { init          = (init, Cmd.none) 
  , view          = view
  , update        = update
  , subscriptions = subscriptions
  }


init : Model
init = 
  { searchBarField = ""
  , searchTime = 0
  , restaurants = []
  , cuisineFilters = Set.empty
  , paymentFilters = Set.empty
  , showMore = False
  } 



-- SUBSCRIPTIONS



subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch 
  [ records GetSearchResults
  , searchTime GetSearchTime
  ]



