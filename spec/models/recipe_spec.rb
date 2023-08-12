require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John Doe')
    recipe = Recipe.new(name: 'Pasta', description: 'Delicious pasta recipe', preparation_time: 30, cooking_time: 20,
                        user:)
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    user = User.create(name: 'John Doe')
    recipe = Recipe.new(description: 'Delicious pasta recipe', preparation_time: 30, cooking_time: 20, user:)
    expect(recipe).not_to be_valid
  end

  it 'is not valid with a short name' do
    user = User.create(name: 'John Doe')
    recipe = Recipe.new(name: 'A', description: 'Delicious pasta recipe', preparation_time: 30, cooking_time: 20,
                        user:)
    expect(recipe).not_to be_valid
  end

  it 'is not valid with a long name' do
    user = User.create(name: 'John Doe')
    long_name = 'a' * 51
    recipe = Recipe.new(name: long_name, description: 'Delicious pasta recipe', preparation_time: 30, cooking_time: 20,
                        user:)
    expect(recipe).not_to be_valid
  end
end
