# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('.join_group').submit ->
    #$(this).find("input[type='submit']").attr('disabled', 'disabled')
    $(this).find("input[type='submit']").val('joining ...').prop('disabled', true)

