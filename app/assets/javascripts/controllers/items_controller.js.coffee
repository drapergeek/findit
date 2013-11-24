Findit.ItemsController = Ember.ArrayController.extend
  sortProperties: ['name']
  sortAscending: true
  updateSearch: (->
    search = @get('searchText')

    if search.length < 1
      @set('model', @get('allItems'))
    else
      currentSearch = @get('model').filter (item, index, self) =>
        @_searchMatchesAnyProperty(item, search)
      @set('model', currentSearch)
  ).observes('searchText')

  _searchMatchesAnyProperty: (item, search) ->
    @_itemMatches(item, 'name', search) ||
      @_itemMatches(item, 'make', search) ||
      @_itemMatches(item, 'model', search) ||
      @_itemMatches(item, 'shortLocation', search)

  _itemMatches: (item, propertyName, search) ->
    property = item.get(propertyName)?.toUpperCase()
    if property
      property.indexOf(search.toUpperCase()) != -1

  _chosenSearchIsAlreadyActive: (chosenSearch) ->
    chosenSearch is @get('sortProperties')[0]

  _setCurrentSearchToChosenSearch: (chosenSearch) ->
    @set('sortProperties', [chosenSearch])
    @set('sortAscending', true)

  actions:
    sort: (chosenSearch) ->
      if @_chosenSearchIsAlreadyActive(chosenSearch)
        @toggleProperty('sortAscending')
      else
        @_setCurrentSearchToChosenSearch(chosenSearch)
      actionFailed = false
