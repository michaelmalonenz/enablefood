# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.meal = {};

meal.show_meal = (id) ->  document.location = '/meals/' + id

meal.delete_meal = (id) ->
  global.askYesNoQuestion('Are you sure?', 'Do you really want to delete this meal?',
    (res) ->
      if (res == true)
        $.ajax({
          url: '/meals/' + id,
          type: 'delete',
          success: () ->
            document.location = '/meals'
        })
  )
  event.stopPropagation()
  return false
