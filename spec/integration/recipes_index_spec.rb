require 'rails_helper'

RSpec.feature 'Recipe Index Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'foo', email: 'foo@example.com', password: '123456')
    @recipe1 = Recipe.create(name: 'Recipe 1', user: @user, preparation_time: 10, cooking_time: 10,
                             description: 'test', public: true)
    @recipe2 = Recipe.create(name: 'Recipe 2', user: @user, preparation_time: 15, cooking_time: 15,
                             description: 'test 2', public: false)

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'User can see recipe list and add recipe button' do
    visit recipes_path
    expect(page).to have_content('Recipe List')
    expect(page).to have_button('Add Recipe')
  end

  scenario 'User can see recipe details on the index page' do
    visit recipes_path
    expect(page).to have_content(@recipe1.name)
    expect(page).to have_content(@recipe1.description)
  end

  scenario 'User can navigate to recipe show page from index' do
    visit recipes_path
    click_link @recipe1.name
    expect(page).to have_current_path(recipe_path(@recipe1))
  end

  scenario 'User can remove a recipe from the index page' do
    visit recipes_path
    expect(page).to have_content(@recipe1.name)
    click_button 'Remove', match: :first
    expect(page).not_to have_content(@recipe1.name)
  end
end
