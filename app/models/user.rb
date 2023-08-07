class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  has_many :recipes, foreign_key: 'user_id'
  has_many :foods, foreign_key: 'user_id'
end
