class MealsController < ApplicationController

  def new
    @meal = Meal.new
    @owner = :current_user
    #@meal.users << User.all
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
    @meal = Meal.find(params[:id])
  end

  def index
    @meals = Meal.all.sort_by { |m| m.date }.reverse
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.new(params)
    if Meal.update(@meal)
      redirect_to @meal
    else
      render 'new'
    end
  end

  private
  def meal_params
    params.require(:meal).permit(:title, :date, :website)
  end
end
