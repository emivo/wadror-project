class Product < ActiveRecord::Base
  has_many :categorisations
  has_many :categories, through: :categorisations
end
