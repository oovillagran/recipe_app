require 'rails_helper'

RSpec.describe UsersController, type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456',
                        password_confirmation: '123456')

    login_as(@user, scope: :user)
  end

  describe 'GET #shopping_list' do
    it 'returns http success' do
      get user_shopping_list_path(user_id: @user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
