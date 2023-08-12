require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456',
                        password_confirmation: '123456')
    @recipe = Recipe.create(name: 'Pasta', description: 'Delicious pasta recipe', preparation_time: 30,
                            cooking_time: 20, user: @user)

    login_as(@user, scope: :user)
  end

  describe 'GET #new' do
    it 'returns http success' do
      get new_user_recipe_recipe_food_path(user_id: @user.id, recipe_id: @recipe.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe_food' do
      recipe = Recipe.create(name: 'Sample Recipe', description: 'Sample Description', preparation_time: 30,
                             cooking_time: 60, user: @user)
      food = Food.create(name: 'Sample Food', measurement_unit: 'grams', price: 2.99, quantity: 100, user: @user)
      post user_recipe_recipe_foods_path(user_id: @user.id, recipe_id: recipe.id),
           params: { recipe_food: { quantity: 1, food_id: food.id, recipe_id: recipe.id } }
      expect(response).to redirect_to(recipe_path(user_id: @user.id, id: recipe.id))
    end

    it 'redirects and shows alert if ingredient already exists in recipe' do
      recipe = Recipe.create(name: 'Sample Recipe', description: 'Sample Description', preparation_time: 30,
                             cooking_time: 60, user: @user)
      food = Food.create(name: 'Sample Food', measurement_unit: 'grams', price: 2.99, quantity: 100, user: @user)
      RecipeFood.create(recipe:, food:, quantity: 1)

      post user_recipe_recipe_foods_path(user_id: @user.id, recipe_id: recipe.id),
           params: { recipe_food: { quantity: 1, food_id: food.id, recipe_id: recipe.id } }
      expect(response).to redirect_to(new_user_recipe_recipe_food_path(user_id: @user.id, recipe_id: recipe.id))
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the recipe_food' do
      recipe = Recipe.create(name: 'Sample Recipe', description: 'Sample Description', preparation_time: 30,
                             cooking_time: 60, user: @user)
      food = Food.create(name: 'Sample Food', measurement_unit: 'grams', price: 2.99, quantity: 100, user: @user)
      recipe_food = RecipeFood.create(recipe:, food:, quantity: 1)

      delete user_recipe_recipe_food_path(user_id: @user.id, recipe_id: recipe.id, id: recipe_food.id)
      expect(response).to redirect_to(recipe_path(user_id: @user.id, id: recipe.id))
      expect(RecipeFood.find_by(id: recipe_food.id)).to be_nil
    end
  end
end
