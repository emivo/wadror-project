require 'rails_helper'
include Helpers
describe "Product" do

  before :each do
    FactoryGirl.create :user
    sign_in(username: "Antti", password: "Lorem1")
  end

  it "should add product when fields are correctly filled" do
    FactoryGirl.create :category
    visit new_product_path
    fill_in('product[name]', with: 'Some great album')
    fill_in('product[price]', with: '10')
    select('CD', from: 'categories_ids[id]')
    fill_in('product[description]', with: 'Rock \'n roll')
    fill_in('product[stock]', with: '100')
    click_button 'Create Product'
    visit products_path
    expect(page).to have_content 'Some great album'
  end

  it "should be change name updated" do
    p = FactoryGirl.create :product, name: 'compact disc'
    visit edit_product_path(p.id)
    fill_in('product[name]', with: 'Compact Disc')
    click_button 'Update Product'
    visit products_path
    expect(page).not_to have_content 'compact disc'
    expect(page).to have_content 'Compact Disc'
  end

end
