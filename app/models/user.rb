class User < ApplicationRecord
  has_many :categories, foreign_key: :created_by
end
