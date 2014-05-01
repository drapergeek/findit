Findit.ItemController = Ember.ObjectController.extend
  editUrl: (->
    "/items/#{@get('id')}/edit"
  ).property('id')

  printLabelUrl: (->
    "/labels/#{@get('id')}"
  ).property('id')
