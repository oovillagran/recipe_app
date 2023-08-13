require 'rails_helper'

RSpec.feature 'New Recipe Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'foo', email: 'foo@example.com', password: '123456')

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'User can see add new recipe form' do
    visit new_recipe_path
    expect(page).to have_content('Add new recipe')
    expect(page).to have_field('Name')
    expect(page).to have_field('Description')
    expect(page).to have_field('Preparation time')
    expect(page).to have_field('Cooking time')
    expect(page).to have_select('Public', options: %w[true false])
    expect(page).to have_button('Add Recipe')
  end

  scenario 'User can create a new recipe' do
    visit new_recipe_path
    fill_in 'Name', with: 'New Recipe'
    fill_in 'Description', with: 'A delicious new recipe'
    fill_in 'Preparation time', with: 20
    fill_in 'Cooking time', with: 30
    select 'false', from: 'Public'
    click_button 'Add Recipe'

    expect(page).to have_current_path(recipes_path)
    expect(page).to have_content('Recipe was added to the table successfully')
  end
end
