
var app = Elm.Main.fullscreen();
var client = algoliasearch('UKOIOQBQNO', '2438133e7c4723989b0a0d8a79c16498');
var helper = algoliasearchHelper(client, 'restaurants', {
  hitsPerPage: 200
});


var coords;

// Get Geolation
navigator.geolocation.getCurrentPosition(function(position) {
  coords = position.coords;
})


// On Result
helper.on('result', function(content){

  app.ports.searchTime.send(
    content.processingTimeMS / 1000
  );

  app.ports.records.send(
    content.hits.map(function(hit) {
      return JSON.stringify(hit);
    })
  )
})


// Search
app.ports.search.subscribe(function(searchTerm) {

  if (coords != null) {
    var latLng =  coords.latitude + ', ' + coords.longitude;

    helper.setQueryParameter('aroundLatLng', latLng);
  }

  helper.setQuery(searchTerm);
  helper.search();
});

