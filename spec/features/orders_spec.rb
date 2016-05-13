require 'rails_helper'
include Helpers

def add_one_cd_to_cart
  product = FactoryGirl.create :product
  c = Category.create name: 'cds'
  product.categories << c

  visit products_path
  click_link 'Generic-CD'
  click_button 'Add to cart'
  click_link 'Cart'
  expect(page).to have_content 'Generic-CD'
  expect(page).to have_content '1'
  expect(page).to have_content 'Remove'
  expect(page).to have_content 'Pay and place an order'
end

describe "Orders" do
  before :each do
    FactoryGirl.create :user
    sign_in(username: "Antti", password: "Lorem1")
  end

  it "should contain newly added product" do
    add_one_cd_to_cart
  end

  it "should contain correct amount of added products" do
    product = FactoryGirl.create :product
    c = Category.create name:'cds'
    product.categories << c

    visit products_path
    click_link 'Generic-CD'
    fill_in('quantity', with: 2)
    click_button 'Add to cart'
    click_link 'Cart'
    expect(page).to have_content 'Generic-CD'
    expect(page).to have_content '2'

  end

  it "should change status to paid when paid" do
    add_one_cd_to_cart
    click_link 'Pay and place an order'
    expect(page).to have_content 'Paid'
    expect(page).not_to have_content 'Pay and place an order'
  end

end