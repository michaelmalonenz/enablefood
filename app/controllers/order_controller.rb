class OrderController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def new
    @order = Order.new()
    @owner = :current_user
    #how do I decide which meal?
  end

  def create
    @order = Order.new(order_params)
    if @order.save()
      redirect_to @order
    else
      render 'new'
    end
  end

  def show

  end

  def edit
  end

  def update
    if @order.update(order_params)
      flash[:notice] = 'Order placed!'
      redirect_to @order.meal
    end
  end

  def attribute
    set_order

  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:description, :cost, :has_paid)
  end
end
