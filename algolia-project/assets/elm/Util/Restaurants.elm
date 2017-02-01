module Util.Restaurants exposing (decoder)


import Json.Decode exposing (Decoder, int, string, list)
import Types exposing (Restaurant)
import Json.Decode.Pipeline exposing (decode, required)


{-
  This is used to decode json into
  an Elm record
-}
decoder : Decoder Restaurant
decoder =
  decode Restaurant
  |>required "address" string
  |>required "area" string
  |>required "city" string
  |>required "country" string
  |>required "diningStyle" string
  |>required "foodType" string
  |>required "id" string
  |>required "image_url" string 
  |>required "mobile_reserve_url" string
  |>required "name" string
  |>required "neighborhood" string
  |>required "payment_options" (list string) 
  |>required "phone" string
  |>required "phoneNumber" string
  |>required "postal_code" string 
  |>required "price" int
  |>required "priceRange" string
  |>required "reserve_url" string
  |>required "reviewsCount" string
  |>required "starsCount" string
  |>required "state" string




