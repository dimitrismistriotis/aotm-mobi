require(["jquery", "aotm/category", "aotm/album", "aotm/updater"], ($, category, album, updater) ->
  updater.updateFromUrlIfOlderThan("http://www.albumofthemonth.net/albums.json", -1)

  # Render albums function (called from settings update and on startup)
  renderAlbums = () ->
    console.log("inside render albums")
    excludedCategories = category.GetExcludedCategories()
    console.log(excludedCategories)

    localAlbumCollection = new album.Collection()
    localAlbumCollection.fetch()

    albumMainView = new album.CollectionView({el: $("#mainAlbums"),excludedCategories: excludedCategories})
    albumMainView.collection = localAlbumCollection
    albumMainView.render()
    console.log("end render albums")

  #Setup menu
  previous_onload = document.body.onload

  document.body.onload = () ->
    console.log("onload")
    #alert("onload")
    document.addEventListener("deviceready", startup, false)
    if (previous_onload and getClass.call(previous_onload) == '[object Function]')
      previous_onload()

  startup = () ->
    console.log("Startup...")
    document.addEventListener("menubutton", toggleMenu, false)

  toggleMenu = () ->
    console.log('toggle Menu')
    if $('#menu').is(':visible')
      console.log('visible switching off')
      $('.menu').hide()
      $('.content').show()
      renderAlbums()
    else
      console.log('nonvisible switching on')
      $('.menu').show()
      $('.content').hide()


  $('#aotmSettingsLink').on("click", toggleMenu)
  $('#aotmMainPageLink').on("click", toggleMenu)
  # End of menu setup
  
  # Categories
  categoriesView = new category.CategoriesView()
  console.log(categoriesView)
  categoriesView.render()
  excludedCategories = category.GetExcludedCategories()
  # End: Categories

  # Display local stored collection:
  localAlbumCollection = new album.Collection()
  localAlbumCollection.fetch()

  albumMainView = new album.CollectionView({el: $("#mainAlbums"),excludedCategories: excludedCategories})
  albumMainView.collection = localAlbumCollection
  albumMainView.render()
  return
)
