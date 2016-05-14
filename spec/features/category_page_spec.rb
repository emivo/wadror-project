require 'rails_helper'
include Helpers
describe "Category page" do

  before :each do
    FactoryGirl.create :user
    sign_in(username: "Antti", password: "Lorem1")
  end
  it "should contain product that is categorized" do
    product = FactoryGirl.create :product
    cds = Category.create name:'cds'
    product.categories << cds
    product.save

    visit categories_path
    expect(page).to have_content 'cds'
    click_link 'cds'
    expect(page).to have_content 'Generic-CD'
  end


  it "should change categorys name when updated" do
    c = Category.create name: 'cds'
    visit edit_category_path(c.id)
    fill_in('category[name]', with: 'CDs')
    click_button 'Update Category'
    visit categories_path
    expect(page).not_to have_content 'cds'
    expect(page).to have_content 'CDs'
  end
end
