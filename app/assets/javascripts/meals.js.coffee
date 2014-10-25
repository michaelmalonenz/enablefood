# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.meal = {};

meal.show_meal = (event, id) ->  document.location = '/meals/' + id

meal.delete_meal = (event, id) ->
  event.stopPropagation()
  global.askYesNoQuestion('Are you sure?', 'Do you really want to delete this meal?',
    (res) ->
      if (res == true)
        $.ajax({
          url: "/meals/#{id}",
          type: 'delete',
          success: document.location = '/meals'
        })
  )
  return false

meal.send_attribute = (controller, objectId, attr, value, callback) ->
  $.post("/#{controller}/attribute", { id : objectId, attribute : attr, value : value }, callback )

meal.update_orders = () ->
  mealId = $('#meal_id').data('meal-id')
  if mealId == undefined
    return
  $.get("/meals/#{mealId}/orders",
  (data) ->
      $('#orders').html(data)
      meal.addOrderListeners()
  )

meal.addOrderListeners = () ->
  $('.ajax-paid').change(() ->
    order_id = this.value
    meal.send_attribute( 'order', order_id, 'has_paid', this.checked, () ->
      meal.update_orders()
    )
  )

window.addEventListener('load', () ->
  meal.addOrderListeners()
  $('.close-orders').click( () ->
    meal_id = $('#meal_id').data('meal-id')
    global.askYesNoQuestion("Are you sure?", "Do you really want to close orders?",
      (res) ->
        if (res == true)
          $.post("/meals/#{meal_id}/closeorders", success: () -> document.location = "/meals/#{meal_id}")
    )
  )

  window.setInterval(meal.update_orders, 30000)
)

