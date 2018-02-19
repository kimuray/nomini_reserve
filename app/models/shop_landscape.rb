class ShopLandscape < ApplicationRecord
  LIMIT_COUNT = 10

  belongs_to :shop

  validates :image, presence: true

  mount_uploader :image, ShopImageUploader
end
