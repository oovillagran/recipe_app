class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @user = current_user
    @food = Food.all
    @recipe = Recipe.find(params[:id])
    @recipe_food = RecipeFood.where(recipe_id: @recipe.id)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:notice] = 'Recipe was added to the table successfully .'
      redirect_to recipes_path
    else
      flash[:alert] = 'Recipe was not added to the table.'
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_foods.destroy_all
    @recipe.destroy
    flash[:notice] = 'Recipe was successfully deleted.'
    redirect_to user_recipes_path
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to recipe_path
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
