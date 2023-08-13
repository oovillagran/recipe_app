require 'rails_helper'

RSpec.feature 'FoodIndex', type: :feature do
  include ActionView::Helpers::NumberHelper
  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456')
    @food1 = Food.create(name: 'corn', measurement_unit: 'unit', price: 4, quantity: 3, user_id: @user.id)
    @food2 = Food.create(name: 'beans', measurement_unit: 'unit', price: 3, quantity: 2, user_id: @user.id)

    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    visit foods_path
  end

  scenario "shows the food's name" do
    expect(page).to have_content(@food1.name)
    expect(page).to have_content(@food2.name)
  end

  scenario "displays 'No food available' message when no foods exist" do
    Food.destroy_all # Clear existing foods
    visit foods_path
    expect(page).to have_content('No food available for this user.')
  end

  scenario 'displays food details including measurement unit and price' do
    expect(page).to have_content(@food1.measurement_unit)
    expect(page).to have_content(number_to_currency(@food1.price, unit: '$', precision: 2))
  end

  scenario "displays 'Delete' link when food is not part of a recipe" do
    visit foods_path
    expect(page).to have_link('Delete', href: food_path(@food1))
    expect(page).to have_link('Delete', href: food_path(@food2))
  end
end
