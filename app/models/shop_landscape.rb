class ShopLandscape < ApplicationRecord
  belongs_to :shop

  validates :image, presence: true

  mount_uploader :image, ShopImageUploader
end
