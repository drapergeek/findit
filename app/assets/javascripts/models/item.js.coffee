Findit.Item = DS.Model.extend
  name: DS.attr('string')
  make: DS.attr('string')
  model: DS.attr('string')
  shortType: DS.attr('string')
  typeOfItem: DS.attr('string')
  shortLocation: DS.attr('string')
  serial: DS.attr('string')

  makeModel: (->
    make = @get('make')
    model = @get('model')
    if make && model
      "#{@get('make')} - #{@get('model')}"
    else if make
      make
    else if model
      model
    else
      ""
  ).property('make', 'model')

  editLink: (->
    "/items/#{@get('id')}/edit"
  ).property('id')

  showLink: (->
    "/items/#{@get('id')}"
  ).property('id')
