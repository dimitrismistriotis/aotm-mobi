require(["jquery", "aotm/album", "aotm/updater"], ($, album, updater) ->
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
      $('#menu').hide()
    else
      console.log('nonvisible switching on')
      $('#menu').show()

  # End of menu setup


  # Display local stored collection:
  localAlbumCollection = new album.Collection()
  localAlbumCollection.fetch()

  albumMainView = new album.CollectionView({ el: $("#mainAlbums") })
  albumMainView.collection = localAlbumCollection
  albumMainView.render()
  return
)
