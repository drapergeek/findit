#= require jquery
#= require jquery_ujs
#= require jquery.ui.datepicker
#= require jquery.hotkeys
#= require twitter/bootstrap
#= require_self

$ ->
  $('.datepicker').datepicker()

  $(document).bind "keydown", "ctrl+i", ->
    window.location.href = "/items/new"

  $('.admin-menu').hide()
  $('.admin-links').on 'click', ->
    $('.admin-menu').slideToggle(100)
