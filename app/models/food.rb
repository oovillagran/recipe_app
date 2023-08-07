class Food < ApplicationRecord
  belongs_to :user

  has_many :food_recipes, foreign_key: 'food_id'

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
