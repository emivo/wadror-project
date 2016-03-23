class Order < ActiveRecord::Base
  belongs_to :user
  has_many :product_quantity_in_orders
  has_many :products, through: :product_quantity_in_orders
end
