require 'test_helper'

class MealTest < ActiveSupport::TestCase

  test 'should close orders' do
    meal = Meal.find(meals(:meal_one))
    meal.close_orders
    assert(meal.orders.length == 2, 'Orders with an empty description and cost of 0 should be removed')
    assert(meal.orders_closed == true, 'Orders should be marked as closed')
    assert(meal.summary == "Toni Pepperoni ✕2\n", 'Same orders should be grouped')
  end

end
