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

  # Decided to use this:
  # http://stackoverflow.com/questions/5651629/backbone-js-collections-and-views
  AlbumsView = Backbone.View.extend({
    el: $('#mainAlbums'),
    template: _.template($('#albums_template').html())
    render: () ->
      console.log('render')
      l = this.collection.length
      for i in [0...l]
        console.log(i)
        item = this.collection.at(i)
        alView = new AlbumView({model: item})
        console.log(alView.render())
        console.log(item.get("band"))
      
      $(this.el).html(this.template(this.model.toJSON()))
  })

  AlbumView = Backbone.View.extend({
    initialize: () ->
      console.log("Alerts suck.")
    render: () ->
      console.log("inside render of album")
      console.log(this.model.toJSON())
      # Compile the template using underscore
      template = _.template( $("#album_template").html() , this.model.toJSON() )
      # Load the compiled HTML into the Backbone "el"
      console.log(this.el)
      console.log(template)
      $(this.el).html(template)
  })
    

  returns =
    Model: Album
    Collection: Albums
    View: AlbumView
    CollectionView: AlbumsView

  return returns
)
