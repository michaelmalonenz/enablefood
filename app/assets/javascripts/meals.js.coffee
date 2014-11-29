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
      meal.update_order_listeners()
  )

meal.update_order_listeners = () ->
  $('.ajax-paid').off('change')
  $('.ajax-paid').on('change', () ->
    order_id = this.value
    meal.send_attribute( 'orders', order_id, 'has_paid', this.checked, meal.update_orders )
  )
  $('.new_order').off('click')
  $('.new_order').on('click', () ->
    user_id = $(this).data('user-id')
    meal_id = $(this).data('meal-id')
    $.post("/orders/construct", { meal_id : meal_id, user_id : user_id}, (data) ->
      $('.orders_container').append(data)
      meal.update_orders()
    )
  )
  $('.delete_order').off('click')
  $('.delete_order').on('click', () ->
    order_id = $(this).data('order-id')
    $.ajax({
      url: "/orders/#{order_id}",
      type: 'delete'
      success: meal.update_orders
    })
    form = $(this).closest('form')
    form.next('div.spacer').remove()
    form.remove()
  )


window.addEventListener('load', () ->
  meal.update_order_listeners()
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



