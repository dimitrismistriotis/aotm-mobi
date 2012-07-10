define(() ->
  Album = Backbone.Model.extend(
    localStorage: new Store("albums_backbone")
    defaults:
      band: ''
      full_review: ''
      cover_location: ''
      mini_review: ''
      user: ''
      category: ''
    initialize: () ->
      #console.log("Welcome to this world")
  )

  Albums = Backbone.Collection.extend(
    model: Album
    url: "http://www.albumofthemonth.net/albums.json"
    localStorage: new Store("albums_backbone")
    initialize: () ->
        this.fetch()
  )
    
  returns =
    Model: Album
    Collection: Albums

  return returns
)
