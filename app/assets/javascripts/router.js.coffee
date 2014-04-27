# For more information see: http://emberjs.com/guides/routing/

Findit.Router.map ()->
  @resource 'items', path: '/', ->
    @resource 'item', path: '/:item_id'

