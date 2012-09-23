require(["jquery", "aotm/category", "aotm/album", "aotm/updater"], ($, category, album, updater) ->
  updater.updateFromUrlIfOlderThan("http://www.albumofthemonth.net/albums.json", -1)

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
    else
      console.log('nonvisible switching on')
      $('.menu').show()
      $('.content').hide()

  $('#aotmSettingsLink').on("click", toggleMenu)
  $('#aotmMainPageLink').on("click", toggleMenu)
  # End of menu setup
  
  # Categories Menu
  categoriesView = new category.CategoriesView()
  console.log(categoriesView)
  categoriesView.render()
  # End: Categories Menu

  # Display local stored collection:
  localAlbumCollection = new album.Collection()
  localAlbumCollection.fetch()

  albumMainView = new album.CollectionView({ el: $("#mainAlbums") })
  albumMainView.collection = localAlbumCollection
  albumMainView.render()
  return
)
