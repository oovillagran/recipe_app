class Recipe < ApplicationRecord
  belongs_to :user

  has_many :food_recipes, foreign_key: 'recipe_id'
  has_many :foods, through: :food_recipes

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 500 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true

  def public?
    public
  end
end
