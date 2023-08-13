require 'rails_helper'

RSpec.feature 'Adding Ingredients to Recipe', type: :feature do
  before(:each) do
    @user = User.create(name: 'foo', email: 'foo@example.com', password: '123456')

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    @recipe = Recipe.create(name: 'Recipe 1', user: @user, preparation_time: 10, cooking_time: 10, description: 'test',
                            public: true)
    @food1 = Food.create(name: 'Food 1', measurement_unit: 'mg', price: 5.0, quantity: 10, user_id: @user.id)
  end

  scenario 'User can see the add ingredient page' do
    visit new_user_recipe_recipe_food_path(user_id: @user, recipe_id: @recipe)
    expect(page).to have_content('Add Ingredient To Recipe')
    expect(page).to have_content('Name')
    expect(page).to have_content('Quantity')
    expect(page).to have_button('Add Ingredient')
  end
end
