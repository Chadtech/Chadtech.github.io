_ = require 'lodash'
fs = require 'fs'



loadJson = ->
  restaurantsFile = fs.readFileSync './restaurants_list.json', 'utf-8'
  restaurants = JSON.parse restaurantsFile

  insertRestaurant = (all, restaurant) ->

    restaurant[ "payment_options" ] = 
      removePaymentOptions restaurant[ "payment_options" ]

    all[ restaurant.objectID ] = restaurant

    all

  _.reduce restaurants, insertRestaurant, {}



removePaymentOptions = (paymentOptions) ->
  dinersClub = "Diners Club" in paymentOptions
  carteBlanche = "Carte Blanche" in paymentOptions

  if dinersClub or carteBlanche 
    unless "Discover" in paymentOptions
      paymentOptions.push "Discover"

  paymentOptions.filter (option) ->
    isntDinersClub = option isnt "Diners Club" 
    isntCarteBlanche = option isnt "Carte Blanche"

    isntCarteBlanche and isntDinersClub



loadCsv = ->

  restaurantsFile = fs.readFileSync './restaurants_info.csv', 'utf-8'

  restaurants = _.map (restaurantsFile.split '\n'), (rowString) ->
    row = rowString.split ';'

    obj = {}

    obj.id = row[0]
    obj.foodType = row[1]
    obj.starsCount = row[2]
    obj.reviewsCount = row[3]
    obj.neighborhood = row[4]
    obj.phoneNumber = row[5]
    obj.priceRange = row[6]
    obj.diningStyle = row[7]

    obj

  _.filter restaurants, (restaurant) ->
    isNumber = not isNaN (parseInt restaurant.id)
    hasId = Boolean(restaurant.id.length)

    hasId and isNumber





restaurants = loadJson()

_.forEach loadCsv(), (restaurant) ->
  {id} = restaurant

  restaurants[ id ] = _.assign restaurant, restaurants[ id ]

  delete restaurants[ id ][ "objectID" ]


restaurants = _.map (_.keys restaurants), (id) ->
  restaurants[ id ]


fs.writeFileSync "restaurants.json", (JSON.stringify restaurants)

# # Uncomment out if you want to read the data
# fs.writeFileSync "restaurants.json", (JSON.stringify restaurants, null, "\t")




