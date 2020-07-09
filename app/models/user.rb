class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, presence: true
  validates :username, presence: true, uniqueness: true

  include Slugify
end
