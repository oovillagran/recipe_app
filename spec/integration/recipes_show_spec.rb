require 'rails_helper'

RSpec.feature 'Recipe Details Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'foo', email: 'foo@example.com', password: '123456')
    @recipe = Recipe.create(name: 'Recipe 1', user: @user, preparation_time: 10, cooking_time: 10, description: 'test',
                            public: true)
    @food1 = Food.create(name: 'Food 1', measurement_unit: 'mg', price: 5.0, quantity: 10, user_id: @user.id)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food1, quantity: 2)

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'User can see recipe details' do
    visit recipe_path(@recipe)

    expect(page).to have_content('Recipes Details')
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content('Preparation time: 10.0 hour(s)')
    expect(page).to have_content('Cooking time: 10.0 hour(s)')
    expect(page).to have_content('Decription: test')
  end

  scenario 'User can see ingredient list for the recipe' do
    visit recipe_path(@recipe)

    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Value')
    expect(page).to have_content('Actions')

    expect(page).to have_content(@recipe_food.food.name)
    expect(page).to have_content('2 mg')
    expect(page).to have_content('$ 10.00')
  end

  scenario 'User can remove an ingredient from the recipe' do
    visit recipe_path(@recipe)
    click_link 'Remove'

    expect(page).not_to have_content(@recipe_food.food.name)
    expect(page).not_to have_content('2 mg')
    expect(page).not_to have_content('$10.00')
  end

  scenario 'User can see action buttons for recipe owner' do
    visit recipe_path(@recipe)

    expect(page).to have_button('Generate Shopping List')
    expect(page).to have_button('Add Ingredient')
  end
end
