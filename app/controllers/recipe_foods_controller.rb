class RecipeFoodsController < ApplicationController
  def new
    @foods = current_user.foods.pluck(:name, :id)
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @existing_food = @recipe.foods.pluck(:id)
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe = Recipe.find(params[:recipe_food][:recipe_id])
    @existing_food = @recipe.foods.pluck(:id)

    if @existing_food.include?(@recipe_food.food_id)
      flash[:alert] = 'Ingredient already exists in your recipe'
      redirect_to new_user_recipe_recipe_food_path(user_id: current_user.id, recipe_id: @recipe.id)
      return
    end

    if @recipe_food.save
      flash[:success] = 'Ingredient successfully added to your recipe'
      redirect_to recipe_path(user_id: current_user.id, id: @recipe_food.recipe_id)
    else
      flash[:alert] = 'Failed to add ingredient to your recipe'
      render 'new'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(user_id: current_user.id, id: @recipe_food.recipe_id)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
