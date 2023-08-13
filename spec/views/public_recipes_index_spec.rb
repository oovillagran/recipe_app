require 'rails_helper'

RSpec.describe 'public_recipes/index.html.erb', type: :view do
  describe 'Testing public recipes page' do
    before(:each) do
      @user = User.create(name: 'foo', email: 'foobar@gmail.com', password: '123456')

      @recipe1 = Recipe.create(name: 'Koki', preparation_time: 1, cooking_time: 2,
                               description: 'Ground black-eyed peas', public: true, user_id: @user.id)
      @recipe2 = Recipe.create(name: 'Salad', preparation_time: 3, cooking_time: 0.1,
                               description: 'Vegetables and vinegar', public: true, user_id: @user.id)
      @recipe3 = Recipe.create(name: 'Steak', preparation_time: 1, cooking_time: 0.5,
                               description: 'Common dish', public: false, user_id: @user.id)

      @food1 = Food.create(name: 'corn', measurement_unit: 3, price: 4, quantity: 3, user_id: @user.id)
      @food2 = Food.create(name: 'beans', measurement_unit: 3, price: 3, quantity: 2, user_id: @user.id)

      @recipe_food1 = RecipeFood.create(quantity: 3, food_id: @food1.id, recipe_id: @recipe1.id)
      @recipe_food2 = RecipeFood.create(quantity: 2, food_id: @food2.id, recipe_id: @recipe1.id)

      assign(:user, @user)
      assign(:recipes, [@recipe1, @recipe2, @recipe3]) # This should be @public_recipes
      assign(:recipe_foods, [@recipe_food1, @recipe_food2])

      # Assigning @public_recipes here
      assign(:public_recipes, [@recipe1, @recipe2])

      render
    end

    it "shows the user name of the public recipe's owner" do
      expect(rendered).to have_content('By: foo')
    end

    it 'shows the public recipe' do
      expect(rendered).to have_content 'Salad'
    end

    it 'does not show the private recipe' do
      expect(rendered).not_to have_content 'Steak'
    end
  end
end
