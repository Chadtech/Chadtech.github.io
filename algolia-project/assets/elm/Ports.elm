port module Ports exposing (..)


port search : String -> Cmd msg

port records : ((List String) -> msg) -> Sub msg

port searchTime : (Float -> msg) -> Sub msg

