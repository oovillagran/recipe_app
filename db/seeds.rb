# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create sample users

user1 = User.create(name: "John Doe", email: "john@doe.com", password: "123456")
user2 = User.create(name: "Jane Doe", email: "jane@doe.com", password: "123456")

# Create sample foods

food1 = Food.create(name: "Chicken", measurement_unit: "kg", price: 1.5, quantity: 2, user_id: 1)
food2 = Food.create(name: "Rice", measurement_unit: "kg", price: 0.5, quantity: 1, user_id: 2)
food3 = Food.create(name: "Chocolate", measurement_unit: "oz", price: 0.5, quantity: 4, user_id: 1)
food4 = Food.create(name: "Milk", measurement_unit: "lt", price: 1, quantity: 1, user_id: 1)

# Create sample recipes

recipe1 = Recipe.create(name: "Chicken Rice", description: "Cook chicken and rice", preparation_time: 10, cooking_time: 20, public: true, user_id: 1)
recipe2 = Recipe.create(name: "Rice Chicken", description: "Cook rice and chicken", preparation_time: 10, cooking_time: 20, public: true, user_id: 2)
recipe3 = Recipe.create(name: "Chocolate and Milk", description: "Added chocolate to warned milk", preparation_time: 5, cooking_time: 10, public: true, user_id: 1)
