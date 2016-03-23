class Product < ActiveRecord::Base
  has_many :categorisations
  has_many :categories, through: :categorisations
  has_many :product_quantity_in_orders
  has_many :orders, through: :product_quantity_in_orders
  has_attached_file :photo, styles: {medium: "200x200>", :thumb => "100x100>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }, size: {in: 0..500.kilobytes }

  validates :name, presence: true, length: { in: 3..20 }, uniqueness: true
  validates :description, presence: true, length: { in: 3..500}
  validates :stock, presence: true, numericality: true
  validates :price, presence: true, numericality: true
end
