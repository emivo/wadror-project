require 'rails_helper'


RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Make"

    expect(user.username).to eq("Make")
  end

  it "is not saved with wrong format password" do
    user = User.create username: "make", email: "make@mail.com", password: "pelkkiapienia", password_confirmation: "pelkkiapienia"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username: "Lorem", email: "make@mail.com", password: "ip", password_confirmation: "ip"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka", email: "make@mail.com"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
end
