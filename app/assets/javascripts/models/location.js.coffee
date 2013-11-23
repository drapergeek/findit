Findit.Location = DS.Model.extend
  fullName: DS.attr('string')
  shortLocation: DS.attr('string')
  name: DS.attr('string')
  items: DS.hasMany('item')
