#= require jquery
#= require jquery_ujs
#= require jquery.ui.datepicker
#= require twitter/bootstrap
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require findit

# for more details see: http://emberjs.com/guides/application/
window.Findit = Ember.Application.create
  rootElement: "#ember-app"

$ ->
  $('.datepicker').datepicker()
