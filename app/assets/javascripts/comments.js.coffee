# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('.create_comment').submit ->
    $(this).find("input[type='submit']").val('sending ...').prop('disabled', true)
    #$(this).find("input[type='submit']").val('Hopp').prop('disabled', false)