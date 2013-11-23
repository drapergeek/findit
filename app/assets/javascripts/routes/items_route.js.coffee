Findit.ItemsRoute = Ember.Route.extend
  model: -> @store.findAll('item')
  setupController: (controller, model) ->
    controller.set('allItems', model)
    controller.set('model', model)
