require 'rails_helper'

RSpec.feature 'Shopping List Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'foo', email: 'foo@example.com', password: '123456')
    @recipe = Recipe.create(name: 'Recipe 1', user: @user, preparation_time: 10, cooking_time: 10, description: 'test',
                            public: true)
    @food1 = Food.create(name: 'Food 1', measurement_unit: 'mg', price: 5.0, quantity: 10, user_id: @user.id)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food1, quantity: 2)
    @shopping_list = {
      @food1 => { quantity: 2, total_price: 10.00 }
    }
    @total_value = 10.00

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'User can see shopping list details' do
    visit user_shopping_list_path(user_id: @user.id, recipe_id: @recipe.id)

    expect(page).to have_content('Shopping List')

    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Price')
  end

  scenario 'User sees a message when there are no ingredients in the shopping list' do
    @shopping_list = {}
    visit user_shopping_list_path(user_id: @user.id, recipe_id: @recipe.id)

    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of ingredients to buy: 0')
  end
end
