require(["jquery", "aotm/album", "aotm/updater"], ($, album, updater) ->
  updater.updateFromUrlIfOlderThan("http://www.albumofthemonth.net/albums.json", -1)

  # Display local stored collection:
  localAlbumCollection = new album.Collection()
  localAlbumCollection.fetch()

  albumMainView = new album.CollectionView({ el: $("#mainAlbums") })
  albumMainView.collection = localAlbumCollection
  albumMainView.render()
  return
)
