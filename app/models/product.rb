class Product < ActiveRecord::Base
  has_many :categorisations
  has_many :categories, through: :categorisations
  has_attached_file :photo, styles: { medium: "320x280>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :description, presence: true
  validates :stock, presence: true
  validates :price, presence: true
end
