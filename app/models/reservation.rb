class Reservation < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :shop
  belongs_to :reservation_category
  has_many :enquetes

  # Validation
  validates :people_count, presence: true
  validates :use_date, presence: true
  validates :use_time, presence: true
  validates :status  , presence: true

  enum status: { done: 0, visited: 1, answered: 2, canceled: 3 }

  # カテゴリに基づく料金
  def category_price
    shop.valid_categories.find_by(reservation_category_id: self.id).price
  end

  # 価格表示
  def output_price
    ShopUsage.find_by(shop: self.shop, reservation_category: self.reservation_category)&.price
  end
end
