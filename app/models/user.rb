class User < ActiveRecord::Base
  # Remember to create a migration!
  has_secure_password

  validates :username, length: { minimum: 2 }
  validates :username, presence: true
  validates :username, uniqueness: true
  # validates :password_digest, length: { minimum: 8 }


  has_many  :prayerrequests
  has_many  :comments
  has_many  :favorites
end
