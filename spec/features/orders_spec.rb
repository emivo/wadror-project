require 'rails_helper'
include Helpers

def create_product
  product = FactoryGirl.create :product
  c = Category.create name: 'cds'
  product.categories << c
end

def add_one_cd_to_cart
  visit products_path
  click_link 'Generic-CD'
  click_button 'Add to cart'
  click_link 'Cart'
  expect(page).to have_content 'Generic-CD'
  expect(page).to have_content '1'
  expect(page).to have_content 'Remove'
  expect(page).to have_content 'Pay and place an order'
end

def add_cart_and_check_quantity(quantity)
  visit products_path
  click_link 'Generic-CD'
  fill_in('quantity', with: 2)
  click_button 'Add to cart'
  click_link 'Cart'
  expect(page).to have_content 'Generic-CD'
  expect(page).to have_content quantity
end

describe "Orders" do
  before :each do
    FactoryGirl.create :user
    sign_in(username: "Antti", password: "Lorem1")
    create_product
  end

  it "should contain newly added product" do
    add_one_cd_to_cart
  end

  it "should contain correct amount of added products" do
    quantity = '2'
    add_cart_and_check_quantity(quantity)

    quantity = '4'
    add_cart_and_check_quantity(quantity)
  end

  it "should change status to paid when paid" do
    add_one_cd_to_cart
    click_link 'Pay and place an order'
    expect(page).to have_content 'Paid'
    expect(page).not_to have_content 'Pay and place an order'
  end

  it "should not to be able to pay without any product" do
    click_link 'Cart'
    expect(page).not_to have_content 'Pay and place an order'
    page.driver.post(pay_path(1))
    expect(page).to have_content 'cart is empty'
  end

  it "should be able to change cart with unpaid one" do
    add_one_cd_to_cart
    click_link 'Sign out'
    add_one_cd_to_cart
    sign_in(username: "Antti", password: "Lorem1")
    click_link 'Orders'
    click_link '1'
    expect(page).to have_content 'Change current cart to this order'
    click_link 'Change current cart to this order'
    expect(page).to have_content 'This is now your current cart'
  end

end