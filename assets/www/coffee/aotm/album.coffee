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
    comparator: (album) ->
      return - parseInt(album.get("id"))
  )

  AlbumsView = Backbone.View.extend({
    el: $('#mainAlbums'),
    template: _.template($('#albums_template').html())
    initialize: () ->
      # foo
    render: () ->
      if !this.options.excludedCategories?
        this.options.excludedCategories = []
      l = this.collection.length
      this.collection.sort()
      albumsHtml = ""
      for i in [0...l]
        item = this.collection.at(i)
        currentCategoryID = item.get("category_id")
        #console.log("current category id: #{currentCategoryID}")

        excludedCategory = parseInt(item.get("category_id")) in this.options.excludedCategories
        continue if excludedCategory

        alView = new AlbumView({model: item})
        #console.log(alView.render())
        alView.render()
        albumsHtml += alView.html_result
      
      #console.log("total html:")
      #console.log(albumsHtml)
      $(this.el).html(this.template({'albums_list_items' : albumsHtml}))
  })

  AlbumView = Backbone.View.extend({
    initialize: () ->
      # Do nothing for the moment
      return
    render: () ->
      #console.log("inside render of album")
      #console.log(this.model.toJSON())
      # Compile the template using underscore
      template = _.template( $("#album_template").html() , this.model.toJSON() )
      # Load the compiled HTML into the Backbone "el"
      #console.log(this.el)
      #console.log(template)
      $(this.el).html(template)
      this.html_result = template
  })
    

  returns =
    Model: Album
    Collection: Albums
    View: AlbumView
    CollectionView: AlbumsView

  return returns
)
