class Shop < ApplicationRecord
  mount_uploader :image, ShopImageUploader

  # Association
  has_many :reservations
  has_many :reservation_categories, through: :shop_usages
  has_many :shop_usages, dependent: :destroy
  accepts_nested_attributes_for :shop_usages, allow_destroy: true

  # Validation
  validates :name,     presence: true
  validates :phone_number,  presence: true, format: { with: /\A[0-9-]+\z/, message: "電話番号は数字、ハイフンのみ入力できます。"}

  # 全角を半角に変換
  def phone_number=(value)
    value.tr!('０-９ー','0-9-') if value.is_a?(String)
    super(value)
  end

  # 価格が設定されている予約カテゴリ
  def valid_categories
    shop_usages.where("price > 0")
  end

end
