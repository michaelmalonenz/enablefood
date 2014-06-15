require 'test_helper'

class MealControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get details" do
    get :details
    assert_response :success
  end

end
