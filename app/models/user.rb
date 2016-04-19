class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :password, length: {minimum: 4},
            format: {
                with: /\d.*[A-Z]|[A-Z].*\d/,
                message: "has to contain one number and one upper case letter"
            }
  validates :username, uniqueness: true, length: { in: 3..20 }
  validates :email, length: { in: 5..254 }, format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: "has to contain one @ and one ."
  }
end
