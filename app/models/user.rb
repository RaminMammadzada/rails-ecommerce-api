class User < ApplicationRecord
  has_secure_password
  has_many :categories, foreign_key: :created_by
  validates_presence_of :name, :email, :password_digest
end
