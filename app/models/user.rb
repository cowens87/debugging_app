class User < ApplicationRecord
  has_many :posts
  has_many :comments, thro: :posts
  validates :name, presence: false
  validates :emai, uniqueness: true
end
