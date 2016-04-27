require 'rails_helper'
include Helpers
describe "Product page" do

  before :each do
    sign_in(username: "Antti", password: "Lorem1")
  end

  it "should contain products that has been created" do
    FactoryGirl.create :product
    visit products_path
    expect(page).to have_content 'Products'
    expect(page).to have_content 'CD'
  end
end