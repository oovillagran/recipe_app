require 'rails_helper'

RSpec.feature 'PublicRecipesIndex', type: :feature do
  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456')
    @recipe1 = Recipe.create(name: 'Recipe 1', user: @user, public: true)

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'displays the list of public recipes' do
    visit public_recipes_path
    expect(page).to have_content('Recipes&Foods')
    expect(page).to have_content('Public Recipes')
  end
end
