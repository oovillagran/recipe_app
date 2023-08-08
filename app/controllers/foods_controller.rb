class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods
    @recipe_foods = RecipeFood.joins(recipe: :user).where(users: { id: @user.id })
    p @recipe_foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      flash[:success] = 'Food was successfully created'
      redirect_to food_path(@food)
    else
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:danger] = 'Food was successfully deleted'
    redirect_to foods_path
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
