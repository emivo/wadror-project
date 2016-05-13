require 'rails_helper'
include Helpers
describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  it "registered should be able to login in" do
    visit root_path
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Sign in')
    sign_in(username: "Antti", password: "Lorem1")
    expect(page).to have_content('Sign out')
    visit users_path
    click_link 'Antti'
    expect(page).to have_content('Username:')
    expect(page).to have_content('Antti')
    expect(page).to have_content('Street:')
    expect(page).to have_content('Email:')
    expect(page).to have_content('Zip code:')
    expect(page).to have_content('City')
  end

  it "should be created with correct information" do
    visit signup_path
    fill_in('user[username]', with: 'pekka')
    fill_in('user[email]', with: 'maili@email.com')
    fill_in('user[address]', with: 'katuosoite')
    fill_in('user[city]', with: 'kapunni')
    fill_in('user[zip_code]', with: '01000')
    fill_in('user[password]', with: 'Ipsum2')
    fill_in('user[password_confirmation]', with: 'Ipsum2')
    click_button 'Create User'
    # admin login
    sign_in(username: "Antti", password: "Lorem1")

    visit users_path
    expect(page).to have_content 'pekka'
  end
  it "is logged out when sign out is clicked" do
    sign_in(username: "Antti", password: "Lorem1")
    click_link 'Sign out'
    expect(page).not_to have_content('Sign out')
    expect(page).to have_content('You have been successfully logged out')
  end
end