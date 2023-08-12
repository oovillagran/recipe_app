require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456',
                        password_confirmation: '123456')
    @recipe = Recipe.create(name: 'Pasta', description: 'Delicious pasta recipe', preparation_time: 30, cooking_time: 20, user: @user)

    login_as(@user, scope: :user)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get user_recipes_path(user_id: @user.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get user_recipe_path(user_id: @user.id, id: @recipe.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get new_user_recipe_path(user_id: @user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
