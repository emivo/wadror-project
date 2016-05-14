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
    sign_in(username: 'Antti', password: 'Lorem1')
    expect(page).to have_content('Sign out')
    visit user_path(User.first)
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
    sign_in(username: 'Antti', password: 'Lorem1')

    visit users_path
    expect(page).to have_content 'pekka'
  end
  it "is logged out when sign out is clicked" do
    sign_in(username: 'Antti', password: 'Lorem1')
    click_link 'Sign out'
    expect(page).not_to have_content('Sign out')
    expect(page).to have_content('You have been successfully logged out')
  end

  it "cannot modify or look except own profile" do
    FactoryGirl.create :user, username: 'Mikko', admin: false
     sign_in(username: 'Mikko', password: 'Lorem1')

    visit user_path(User.first)
    expect(page).to have_content 'You can edit only your own profile'
  end


  it "should be change name updated" do
    sign_in(username: 'Antti', password: 'Lorem1')
    visit edit_user_path(User.first)
    fill_in('user[password]', with: 'TopSecret1')
    fill_in('user[password_confirmation]', with: 'TopSecret1')
    click_button 'Update User'
    click_link 'Sign out'
    sign_in(username: 'Antti', password: 'TopSecret1')
    expect(page).to have_content 'Welcome back!'
  end
end