class Shop < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :image, ShopImageUploader

  # Association
  has_many :reservations
  has_many :reservation_categories, through: :shop_usages
  has_many :shop_usages, dependent: :destroy

  accepts_nested_attributes_for :shop_usages, allow_destroy: true, reject_if: :all_blank

  # Validation
  validates :name,     presence: true
  validates :phone_number,
            presence: true,
            format: { with: /\A[0-9-]+\z/, message: '電話番号は数字、ハイフンのみ入力できます。' },
            unless: :new_record?

  # 全角を半角に変換
  def phone_number=(value)
    value.tr!('０-９ー','0-9-') if value.is_a?(String)
    super(value)
  end

  # 価格が設定されている予約カテゴリ
  def valid_categories
    shop_usages.where("price > 0")
  end

  # 有効カテゴリのセレクトボックス表示
  def valid_categories_list
    valid_categories.map{|category| ["#{category.reservation_category.name} #{category.price}円", category.reservation_category_id]}
  end

  def build_shop_usages
    build_count = ReservationCategory.count - self.shop_usages.size
    build_count.times { self.shop_usages.build }
  end
end
