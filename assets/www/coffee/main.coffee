require(["jquery", "aotm/album"], ($, album) ->
  console.log('inside module')
  
  album01 = new album.Model()
  albumCollection = new album.Collection(album01)

  return
)
