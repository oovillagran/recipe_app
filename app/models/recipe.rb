class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods, foreign_key: 'recipe_id'
  has_many :foods, through: :recipe_foods

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 500 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true

  def total_price
    # Total price for the recipe
    recipe_foods.sum { |rf| rf.food.price * rf.quantity }
  end
end
