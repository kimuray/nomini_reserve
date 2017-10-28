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

  enum status: { applying: 0, remand: 1, done: 2, visited: 3, answered: 4, canceled: 5 }

  # カテゴリに基づく料金
  def category_price
    shop.valid_categories.find_by(reservation_category_id: self.id).price
  end

  # 価格表示
  def output_price
    ShopUsage.find_by(shop: self.shop, reservation_category: self.reservation_category)&.price
  end

  def sum_price
    output_price * people_count
  end

  def tax_included_price
    (sum_price * 1.08).floor # TODO: 消費税をどこかで定数化する
  end
end
