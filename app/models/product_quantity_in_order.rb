class ProductQuantityInOrder < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: true
end
