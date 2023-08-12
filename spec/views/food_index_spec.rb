require 'rails_helper'

RSpec.describe 'foods/index.html.erb', type: :view do
  describe 'Testing foods index page' do
    before(:each) do
      @user = User.create(name: 'foo', email: 'foobar@gmail.com', password: '123456')
      @food1 = Food.create(name: 'corn', measurement_unit: 3, price: 4, quantity: 3, user_id: @user.id)
      # @food2 = Food.create(name: 'beans', measurement_unit: 1, quantity: 2, price: 3, user_id: @user.id)
      @food2 = Food.create(name: 'beans', measurement_unit: 1, price: 3, quantity: 2, user_id: @user.id)

      assign(:foods, [@food1, @food2])
      render
    end

    it 'Check if the foods have been added to the list' do
      expect(rendered).to have_content 'corn'
      expect(rendered).to have_content 'beans'
    end

    it 'Shows the price of each food' do
      expect(rendered).to have_content '$4.00'
      expect(rendered).to have_content '$3.00'
    end

    it 'Shows a delete button to delete a food' do
      expect(rendered).to have_link('Delete')
    end
  end
end
