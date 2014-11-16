require 'test_helper'

class OrderControllerTest < ActionController::TestCase

  setup do
    @controller = OrdersController.new
    @user = users(:user_one)
    sign_in @user
  end

  test 'should render order correctly' do
    post :construct, :meal_id => meals(:meal_one).id, :user_id => @user.id
    assert_response :success
    assert_template 'orders/_order_form'
  end

end
