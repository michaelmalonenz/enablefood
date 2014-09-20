class OrderController < ApplicationController

  before_action :set_order, only: [:update, :attribute]

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

  def order_params
    params.require(:order).permit(permitted_attributes)
  end
end
