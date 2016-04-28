# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create name:"CD"
Category.create name:"Casette"
users = 20
products = 50
categories = 5

(1...users).each do |i|
  User.create! username:"user_#{i}", password:"Passwd1", password_confirmation:"Passwd1", email: "eemaili@mail.com"
end

(1...categories).each do |i|
  Category.create! name:"category_#{i}"
end

(1...products).each do |i|
  Product.create! name:"product_#{i}", description:"Generic product", stock:10, price:9.95
end

Product.all.each do |p|
  p.categories << Category.first
end