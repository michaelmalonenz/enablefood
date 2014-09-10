class OrderController < ApplicationController

  before_action :set_order, only: [:update, :attribute]

  def update
    if @order.update(order_params)
      flash[:notice] = 'Order placed!'
      redirect_to @order.meal
    end
  end

  def attribute
    parameters = attr_params
    if permitted_attributes.include? paramters[:attribute]
      @order.send(params[:attribute]+'=', params[:value])
      @order.save()
      render :nothing => true, status: :ok
    else
      render plain: "attribute '#{parameters[:attribute]}' not permitted", status: :bad_request
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def attr_params
    params.permit(:attribute, :value)
  end

  def permitted_attributes
    [:description, :cost, :has_paid]
  end

  def order_params
    params.require(:order).permit(permitted_attributes)
  end
end
