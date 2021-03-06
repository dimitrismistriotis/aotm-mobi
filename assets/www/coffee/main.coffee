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
      # Page needs to be fetched again, in order to refresh content with new changes
      # TODO: maybe just elements should be refreshed.
      location.reload()
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
