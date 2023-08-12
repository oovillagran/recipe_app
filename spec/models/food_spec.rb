require 'rails_helper'

RSpec.describe Food, type: :model do
  it "is valid with valid attributes" do
    user = User.create(name: "John Doe")
    food = Food.new(name: "Carrot", quantity: 5, user: user)
    expect(food).to be_valid
  end

  it "is not valid without a name" do
    user = User.create(name: "John Doe")
    food = Food.new(quantity: 5, user: user)
    expect(food).not_to be_valid
  end

  it "is not valid with a short name" do
    user = User.create(name: "John Doe")
    food = Food.new(name: "A", quantity: 5, user: user)
    expect(food).not_to be_valid
  end

  it "is not valid with a long name" do
    user = User.create(name: "John Doe")
    long_name = "a" * 51
    food = Food.new(name: long_name, quantity: 5, user: user)
    expect(food).not_to be_valid
  end
end
