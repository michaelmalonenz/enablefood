# encoding: utf-8
require 'test_helper'

class MealControllerTest < ActionController::TestCase

  setup do
    @controller = MealsController.new
    @user = users(:user_one)
    sign_in @user
  end

  test 'should post create' do
    num_orders = Order.all.count
    user_ids = [ User.find(users(:user_one)).id, User.find(users(:user_two)).id]
    post :create, :meal => { :title => 'A new Meal', :date => '2014-09-29',
                             :website => 'https://food.taitenable.com',
                             :user_ids => user_ids}
    assert_response :redirect
    assert( (Order.all.count - num_orders) == user_ids.count, 'only created orders for the users given' )
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get show' do
    get :show, :id => meals(:meal_one).id
    assert_response :success
  end

  test 'should close orders' do
    meal = meals(:meal_one)
    post :close_orders, :id => meal.id
    assert_response :success
    meal = Meal.find(meals(:meal_one))
    assert(meal.orders.length == 2, 'Orders with an empty description and cost of 0 should be removed')
    assert(meal.orders_closed == true, 'Orders should be marked as closed')
    assert(meal.summary == "Toni Pepperoni ✕2\n", 'Same orders should be grouped')
  end

  teardown do
    sign_out @user
  end

end
