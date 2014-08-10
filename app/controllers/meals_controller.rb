class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def new
    @meal = Meal.new
    @owner = :current_user
    @users = User.all
  end

  def create
    @meal = Meal.new(meal_params)
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
    if @meal.update(meal_params)
      flash[:notice] = 'Meal successfully saved'
      redirect_to @meal
    end
  end

  def destroy
    if @meal.destroy
      flash[:notice] = 'Meal successfully deleted'
      redirect_to meals_path
    end
  end

  private
  def set_meal
    @meal = Meal.find(params[:id])
  end
  def meal_params
    params.require(:meal).permit(:title, :date, :website, :user_ids => [])
  end
end
