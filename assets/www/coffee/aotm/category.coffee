define(() ->
  console.log("inside category")
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
    initialze: () ->
      this.fetch()
  )

  returns =
    Model: Category
    Collection: Categories
)
