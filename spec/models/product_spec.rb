require 'rails_helper'

RSpec.describe Product, type: :model do
  it "has correct information and is saved to datebase" do
    product = Product.create name: 'Levy', price: 10, description: 'Tyhjä Cd', stock: 100
    expect(product.name).to eq("Levy")
    expect(product.price).to eq(10)
    expect(product.description).to eq("Tyhjä Cd")
    expect(product.stock).to eq(100)
    expect(product).to be_valid
  end
  it "is not saved without stock" do
    product = Product.new name: 'Levy', price: 10, description: 'Tyhjä Cd'
    expect(product).not_to be_valid
  end
  it "is not saved without price" do
    product = Product.new name: 'Levy', stock: 10, description: 'Tyhjä Cd'
    expect(product).not_to be_valid
  end

  it "is not saved without description" do
    product = Product.new name: 'Levy', price: 10, stock: 1000
    expect(product).not_to be_valid
  end

  it "is not saved if name already taken" do
    Product.create name: 'Levy', price: 10, description: 'Tyhjä Cd', stock: 100
    p2 = Product.create name: 'Levy', price: 9, description: 'Toinen Cd', stock: 100
    expect(p2).not_to be_valid
  end
end
