define(() ->
  console.log('call to updater')

  updateLocalDatabase = (data) ->
    console.log('call to update local database')
    console.log(data)
    #jQuery.each(data.items, (i, val) ->
    #  console.log('-->' + val )
    #  return
    #  )
    return

  updateFromUrlIfOlderThan = (url = "http://www.albumofthemonth.net/albums.json", secondsOverlap = 60*60*12) ->
    console.log("url: #{url} with overlap: #{secondsOverlap}")
    lastUpdateTime = -999
    if secondsOverlap < 0
      console.log('always update')

      jQuery.getJSON(url + "?callback=?", null, (results) ->
        updateLocalDatabase(results)
      )

    return


  return updateFromUrlIfOlderThan:updateFromUrlIfOlderThan
)
