# encoding: utf-8
require 'test_helper'

class MealControllerTest < ActionController::TestCase

  setup do
    @controller = MealsController.new
    @user = users(:user_one)
    sign_in @user
    ActionMailer::Base.deliveries = []
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
    assert_not(ActionMailer::Base.deliveries.empty?)
    assert(ActionMailer::Base.deliveries.count == 2, 'There should be two emails sent')
  end

  test 'should not send emails without payment details' do
    meal = meals(:meal_two)
    post :close_orders, :id => meal.id
    assert_response :success
    assert(ActionMailer::Base.deliveries.count == 0, 'There should be no emails sent if the owner has no payment details')
  end

  test 'should not show deleted users on new' do
    get :new
    assert_response :success
    new_meal = assigns(:meal)
    assert( !new_meal.users.include?( users(:deleted_user)), "deleted users shouldn't appear in the list")
    assert !new_meal.users.empty?, 'is_deleted should be false by default'
  end

  teardown do
    sign_out @user
  end

end
