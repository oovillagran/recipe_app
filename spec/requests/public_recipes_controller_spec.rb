require 'rails_helper'

RSpec.describe PublicRecipesController, type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456',
                        password_confirmation: '123456')

    login_as(@user, scope: :user)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get public_recipes_path
      expect(response).to have_http_status(:success)
    end
  end
end
