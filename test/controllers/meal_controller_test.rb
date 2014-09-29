require 'test_helper'

class MealControllerTest < ActionController::TestCase

  setup do
    @controller = MealsController.new
    @user = User.find_by_email('thing_one@drseuss.com')
    sign_in @user
  end

  test 'should get create' do
    post :create, :meal => { :title => 'A new Meal', :date => '2014-09-29',
                             :website => 'https://food.taitenable.com'}
    assert_response :redirect
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get show' do
    get :show, :id => meals(:meal_one).id
    assert_response :success
  end

  teardown do
    sign_out @user
  end

end
