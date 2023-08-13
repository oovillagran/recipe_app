require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456',
                        password_confirmation: '123456')

    login_as(@user, scope: :user)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get foods_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get new_food_path
      expect(response).to have_http_status(:success)
    end
  end
end
