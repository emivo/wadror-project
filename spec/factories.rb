FactoryGirl.define do
  factory :user do
    username "Antti"
    email "Antti@maili.com"
    address "street 2"
    city "hese"
    zip_code "00010"
    admin true
    password "Lorem1"
    password_confirmation "Lorem1"
  end

  factory :product do
    name "Generic-CD"
    description "some disc"
    price 10.0
    stock 10
  end

  factory :order do

    paid false
  end

  factory :category do
    name "CDs"
    product
  end
end