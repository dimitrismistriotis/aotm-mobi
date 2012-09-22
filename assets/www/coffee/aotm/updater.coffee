define(["aotm/album", "aotm/category"], (album, category) ->
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

  updateLocalCategoriesDatabase = (data) ->
    #console.log("categories upd")
   
    categories = new category.Collection()
    categories.fetch()
    console.log(categories)
    for i in data
      #console.log(i)
      currentID = parseInt(i.id)

      currentCategory = new category.Model()
      currentCategory.set(i)
      currentCategory.save()
      
      #console.log(categories.get(currentCategory))
    #console.log("end: categories upd")
    return

  updateFromUrlIfOlderThan = (albumsUrl = "http://www.albumofthemonth.net/albums.json",
    secondsOverlap = 60*60*12,
    categoriesUrl = "http://www.albumofthemonth.net/categories/getall.json",
    categoriesOverlap = 60*60*12*5) ->
    #console.log("url: #{url} with overlap: #{secondsOverlap}")
    lastUpdateTime = -999
    if secondsOverlap < 0
      #console.log('always update')

      jQuery.getJSON(albumsUrl + "?callback=?", null, (results) ->
        updateLocalDatabase(results)
      )

      # Extra call for categories
      jQuery.getJSON(categoriesUrl + "?callback=?", null, (results) ->
        console.log("categories....")
        updateLocalCategoriesDatabase(results)
      )
    return


  return updateFromUrlIfOlderThan:updateFromUrlIfOlderThan
)
