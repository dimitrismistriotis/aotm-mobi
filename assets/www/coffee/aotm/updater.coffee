define(["aotm/album"], (album) ->
  #console.log('call to updater')

  if not localStorage?
    console.error('Cannot update without local storage')
    throw new Error("Could not access local storage.", "updater")

  store = new Store("albums_backbone")

  updateLocalDatabase = (data) ->
    #console.log('call to update local database')
    for i in data
      currentAlbum = new album.Model()
      currentAlbum.set(i)
      #console.log(currentAlbum)
      # localStorage might throw an error (if turned off or maximum capacity)
      try
        currentAlbum.save()
        # Perhaps here an attempt should be made to retrieve and save the cover
      catch error
        console.error("Could not save object")
        console.error(error)
    return

  updateFromUrlIfOlderThan = (url = "http://www.albumofthemonth.net/albums.json", secondsOverlap = 60*60*12) ->
    #console.log("url: #{url} with overlap: #{secondsOverlap}")
    lastUpdateTime = -999
    if secondsOverlap < 0
      #console.log('always update')

      jQuery.getJSON(url + "?callback=?", null, (results) ->
        updateLocalDatabase(results)
      )

    return


  return updateFromUrlIfOlderThan:updateFromUrlIfOlderThan
)
