class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_many :posts, dependent: :nullify

  validates :title, presence: true
end