define(() ->
  console.log('call to album')
  Album = Backbone.Model.extend(
    defaults:
      full_review: ''
      cover_location: ''
      mini_review: ''
      user: ''
      category: ''
    initialize: () ->
      console.log("Welcome to this world")
  )

  Albums = Backbone.Collection.extend(
    model: Album
  )
    
  returns =
    Model: Album
    Collection: Albums

  return returns
)
