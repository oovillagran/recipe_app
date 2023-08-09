class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  has_many :recipes, foreign_key: 'user_id'
  has_many :foods, foreign_key: 'user_id'

  def shopping_list
    # Get all recipe foods for current user's recipes
    recipe_foods = RecipeFood.where(recipes: { user_id: id })

    # Group recipe foods by their associated food items and calculate the total quantity required for each food item
    recipe_foods.group(:food_id).sum(:quantity)

    # Hash to store shopping list items
    shopping_list = {}

    # Initialize items and values variables
    total_items = 0
    total_value = 0

    # Compare the total quantity of each food item required with the quantity of that food item currently in stock
    required_foods.each do |food_id, quantity|
      food = Food.find(food_id)
      available_quantity = food.quantity || 0
      quantity_required = [0, quantity - available_quantity].max

      next unless quantity_required.positive?

      # Calculate the total price for the required quantity
      total_price = quantity_required * food.price
      shopping_list[food] = { quantity: quantity_required, total_price: }

      # Increment total items and total value
      total_items += quantity_required
      total_value += total_price
    end

    { shopping_list:, total_items:, total_value: }
  end
end
