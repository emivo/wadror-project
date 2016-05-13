require 'rails_helper'
include Helpers
describe "Categories page" do

  before :each do
    FactoryGirl.create :user
    sign_in(username: "Antti", password: "Lorem1")
  end

  it "should contain category that has been created" do
    visit new_category_path
    fill_in('category[name]', with: 'cds')
    click_button 'Create Category'

    visit categories_path
    expect(page).to have_content 'cds'
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