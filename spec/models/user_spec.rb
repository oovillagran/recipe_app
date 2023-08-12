RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'john@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(email: 'john@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'is not valid with a short name' do
    user = User.new(name: 'Ab', email: 'john@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'is not valid with a long name' do
    long_name = 'a' * 51
    user = User.new(name: long_name, email: 'john@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'calculates shopping list correctly' do
    user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
    recipe = Recipe.create(name: 'Pasta', description: 'Delicious pasta recipe', preparation_time: 30,
                           cooking_time: 20, user:)
    food = Food.create(name: 'Tomato', quantity: 2, price: 1, user:)
    RecipeFood.create(recipe:, food:, quantity: 3)

    shopping_list_data = user.shopping_list
    expect(shopping_list_data[:total_items]).to eq(1)
    expect(shopping_list_data[:total_value]).to eq(1)
  end
end
