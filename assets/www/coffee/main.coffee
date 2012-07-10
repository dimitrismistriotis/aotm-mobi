require(["jquery", "aotm/album", "aotm/updater"], ($, album, updater) ->
  updater.updateFromUrlIfOlderThan("http://www.albumofthemonth.net/albums.json", -1)
  album01 = new album.Model()
  albumCollection = new album.Collection(album01)
  
  #console.log(albumCollection)
  #album01.save()
  #albumCollection.fetch()
  #albumCollection.fetch({
  #  success: (messages) ->
  #    console.log(messages)
  #})
   
  return
)
