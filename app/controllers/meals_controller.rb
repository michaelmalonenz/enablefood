class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy, :close_orders, :orders]

  def new
    @meal = Meal.new
    @users = User.all
    @meal.orders.build()
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.users.each do |user|
      @meal.orders << Order.new(:user_id => user.id, :meal_id => @meal.id)
    end
    check_owner
    if @meal.save()
      redirect_to @meal
    else
      render 'new'
    end
  end

  def edit
    @users = User.all
  end

  def index
    @meals = Meal.all.sort_by { |m| m.date }.reverse
  end

  def show
  end

  def update
    @meal.transaction do
      if @meal.update(meal_params)
        unless (@meal.orders_closed?)
          @meal.users.each do |u|
            if Order.where('user_id = ? AND meal_id = ?', u.id, @meal.id).empty?
              @meal.orders.create(:user => u)
            end
          end
        end
        check_owner
        flash[:notice] = 'Meal successfully saved'
      else
        flash[:alert] = "Meal couldn't be saved"
      end
    end
    redirect_to @meal
  end

  def destroy
    if @meal.destroy
      render :nothing => true, :status => 200
      flash[:notice] = 'Meal successfully deleted'
    end
  end

  def close_orders
    @meal.transaction do
      @meal.orders_closed = true
      @meal.orders.each do |o|
        if (o.description.blank? && o.cost == 0)
          Order.destroy(o)
        end
      end
      @meal.generate_summary!
      @meal.save()
      flash[:notice] = "Orders closed for #{@meal.title}!"
    end
    render :nothing => true, status => :ok
  end

  def orders
    render :partial => 'order/order_table', status => :ok
  end

  private
  def check_owner
    @meal.owner_id = current_user.id if (@meal.users.select { |u| u.id == @meal.owner_id }).empty?
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:title, :date, :website, :owner_id, :user_ids => [], :order_ids => [])
  end
end
