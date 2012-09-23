define(() ->
  console.log("inside category")

  swapSelection = () ->
    id = this.getAttribute("data-id")
    nextValue = if (this.getAttribute("data-selected") == "Y") then "N" else "Y"
    categories = new Categories()
    currentCategory = categories.get(id)
    console.log(currentCategory)
    currentCategory.set("selected", nextValue)
    currentCategory.save()

    this.setAttribute("data-selected", nextValue)
    # visual:
    if (nextValue == "Y")
      $(this).removeClass("disabled")
    else if (nextValue == "N")
      $(this).addClass("disabled")
    else
      console.error("Unknown selected value reached")
    console.log("swapping #{id} to #{nextValue}")

  Category = Backbone.Model.extend(
    localStorage: new Store("categories_backbone")
    defaults:
      name: ''
      selected: 'Y'
    initialize: () ->
      #console.log("Welcome to this world")
  )

  Categories = Backbone.Collection.extend(
    model: Category
    localStorage: new Store("categories_backbone")
    initialize: () ->
      this.fetch()
    getExcluded: () ->
      console.log("collection")
      console.log(new Categories())
      return _.filter(_.toArray(new Categories()), (item) ->
        console.log(item.get("selected"))
        return item.get("selected") == "N"
      )
  )

  CategoriesView = Backbone.View.extend({
    model: Categories
    el: $('#catemp')
    initialize: () ->
      console.log("initialize")
    render: () ->
      #console.log("cats render")
      categoriesHtml = ""
      categories = new Categories()
      while (c = categories.shift())
        console.log(c)
        catHtml = "<a href=\"#\" class=\"btn-categories btn btn-success #{if c.get("selected") == "Y" then "" else "disabled"} \" data-id=\"#{c.get("id")}\" data-selected=\"#{c.get("selected")}\">#{c.get("name")}</a><br />"
        categoriesHtml += catHtml

      $(this.el).html(categoriesHtml)

      $(this.el).find("a").each( (i, element) ->
        #console.log(i)
        element.onclick = swapSelection
      )

      #console.log("end: cats render")
  })

  getExcludedCategories = () ->
    categories = new Categories()
    return (category.get("id") for category in categories.getExcluded())

  returns =
    Model: Category
    Collection: Categories
    CategoriesView: CategoriesView
    GetExcludedCategories: getExcludedCategories
)
