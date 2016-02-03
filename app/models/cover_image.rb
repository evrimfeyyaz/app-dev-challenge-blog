class CoverImage < ActiveRecord::Base
  belongs_to: :image, dependent: :destroy
  belongs_to: :post, dependent: :destroy
end