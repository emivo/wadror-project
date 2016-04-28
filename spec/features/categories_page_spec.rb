require 'rails_helper'
include Helpers
describe "Categories page" do

  before :each do
    sign_in(username: "Antti", password: "Lorem1")
  end

  it "should contain category that has been created" do
    product = FactoryGirl.create :product
    #c = Category.create name:'cds'

    visit categories_path
    #expect(page).to have_content 'cds'
  end
end