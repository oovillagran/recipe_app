require 'rails_helper'

RSpec.feature 'NewFood', type: :feature do
  before do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456')
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    visit new_food_path
  end

  scenario 'displays the page title' do
    expect(page).to have_content('Add a new food')
  end

  scenario 'displays a form to add a new food' do
    expect(page).to have_selector('form.add-food-form')
  end

  scenario 'displays labels and input fields for food attributes' do
    expect(page).to have_content('Name')
    expect(page).to have_selector('input[name="food[name]"]')
    expect(page).to have_selector('select[name="food[measurement_unit]"]')
    expect(page).to have_content('Price')
    expect(page).to have_selector('input[name="food[price]"]')
    expect(page).to have_content('Quantity')
    expect(page).to have_selector('input[name="food[quantity]"]')
  end

  scenario 'displays a submit button' do
    expect(page).to have_selector('input[type="submit"][value="Add Food"]')
  end

  scenario 'adds a new food when the form is submitted with valid data' do
    fill_in 'food[name]', with: 'New Food'
    select 'Kg', from: 'food[measurement_unit]'
    fill_in 'food[price]', with: 10.50
    fill_in 'food[quantity]', with: 5
    click_button 'Add Food'

    expect(page).to have_content('New Food')
  end
end
