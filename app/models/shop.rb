class Shop < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :image, ShopImageUploader

  # Association
  has_many :reservations
  has_many :reservation_categories, through: :shop_usages
  has_many :shop_usages, dependent: :destroy
  has_many :shop_landscapes, dependent: :destroy
  belongs_to :city, foreign_key: :city_code, primary_key: :city_code, optional: true
  belongs_to :prefecture, optional: true

  accepts_nested_attributes_for :shop_usages, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :shop_landscapes, allow_destroy: true, reject_if: :all_blank

  # Validation
  validates :name,     presence: true
  validates :phone_number,
            presence: true,
            format: { with: /\A[0-9-]+\z/, message: '電話番号は数字、ハイフンのみ入力できます。' },
            unless: :new_record?

  scope :can_display, -> {
    where(is_display: true, is_agree: true)
  }

  attr_accessor :address

  before_validation do
    self.address = address_text
  end

  geocoded_by :address
  before_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

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

  def build_shop_landscapes
    build_count = ShopLandscape::LIMIT_COUNT - shop_landscapes.size
    build_count.times { shop_landscapes.build }
  end

  def correct?(current_shop)
    self == current_shop
  end

  # 有効なカテゴリ内でもっとも高い価格を取得
  def top_price
    shop_usages.pluck(:price).max
  end

  #TODO deviseメール対策(要改善)
  def full_name_kana
    name
  end

  def address_text
    "#{prefecture.name} #{city.name} #{area_text} #{address_detail}"
  end
end
