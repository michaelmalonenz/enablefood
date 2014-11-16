class OrdersController < ApplicationController

  before_action :set_order, only: [:update, :attribute]

  def construct
    sanitised_params = create_params
    @order = Order.create(meal_id: sanitised_params[:meal_id], user_id: sanitised_params[:user_id])
    render :partial => 'order_form', status => :created
  end

  def update
    if @order.meal.orders_closed?
      flash[:alert] = 'Meal has been closed'
    elsif @order.update(order_params)
      flash[:notice] = 'Order placed!'
    end
    redirect_to @order.meal
  end

  def attribute
    @order.send(params[:attribute]+'=', params[:value])
    @order.save()
    render :nothing => true, status: :ok
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def attr_params
    params.permit(:id, :attribute, :value)
  end

  def permitted_attributes
    [:description, :cost, :has_paid]
  end

  def create_params
    params.permit(:user_id, :meal_id)
  end

  def order_params
    params.require(:order).permit(permitted_attributes)
  end
end
