Findit.Item = DS.Model.extend
  name: DS.attr('string')
  make: DS.attr('string')
  modelName: DS.attr('string')
  typeOfItem: DS.attr('string')
  shortLocation: DS.attr('string')
  serial: DS.attr('string')
  inventoriedAt: DS.attr()
  locationFullName: DS.attr()
  userName: DS.attr()
  typeOfItem: DS.attr()
  ram: DS.attr()
  hardDrive: DS.attr()
  purchasedAt: DS.attr()
  warrantyExpiresAt: DS.attr()
  surplusedAt: DS.attr()
  processor: DS.attr()
  operatingSystemName: DS.attr()

  editLink: (->
    "/items/#{@get('id')}/edit"
  ).property('id')

  showLink: (->
    "/items/#{@get('id')}"
  ).property('id')
