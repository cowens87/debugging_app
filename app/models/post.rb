class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, presence: true, uniqueness: false
  validates :content, presence: true, length: { mininum: 10 }
end
