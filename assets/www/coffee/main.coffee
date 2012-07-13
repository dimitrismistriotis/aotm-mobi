require(["jquery", "aotm/album", "aotm/updater"], ($, album, updater) ->
  updater.updateFromUrlIfOlderThan("http://www.albumofthemonth.net/albums.json", -1)
  localAlbumCollection = new album.Collection()
  localAlbumCollection.fetch()
  console.log(localAlbumCollection)

  albumMainView = new album.CollectionView({ el: $("#mainAlbums") })
  console.log(albumMainView)
  albumMainView.collection = localAlbumCollection
  albumMainView.render()
  return
)
