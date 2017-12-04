class Reservation < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :shop
  belongs_to :reservation_category, optional: true
  has_many :enquetes
  has_one :reservation_benefit
  has_one :reservation_payment

  # Validation
  validates :people_count, presence: true
  validates :use_date, presence: true
  validates :use_time, presence: true
  validates :status  , presence: true

  enum status: { applying: 0, remand: 1, done: 2, visited: 3, paid: 4, answered: 5, canceled: 6 }

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

  def setting_payment(params=nil)
    payment = build_reservation_payment(params)
    payment.user = user
    payment.limited_on = Date.tomorrow # TODO: 決済日付が決定次第変更可能性あり
    payment
  end
end
