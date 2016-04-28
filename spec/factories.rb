FactoryGirl.define do
  factory :user do
    username "Antti"
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