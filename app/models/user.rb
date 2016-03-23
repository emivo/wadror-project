class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :username, uniqueness: true, length: { in: 3..20 }
  validates :password, length: { in: 3..72 }
end
