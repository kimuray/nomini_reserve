class Reservation < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :shop
  belongs_to :reservation_category, optional: true
  has_many :enquetes
  has_one :reservation_benefit
  has_one :reservation_payment, dependent: :destroy

  # Validation
  validates :people_count, presence: true
  validates :use_date, presence: true
  validates :use_time, presence: true
  validates :status  , presence: true
  validates :reservation_category_id, presence: true, unless: :is_alacarte

  before_create :delete_reservation_category_when_alacarte

  enum status: { applying: 0, remand: 1, done: 2, visited: 3, paid: 4, answered: 5, canceled: 6 }

  # カテゴリに基づく料金
  def category_price
    shop.valid_categories.find_by(reservation_category_id: self.id).price
  end

  # 価格表示
  def output_price
    unless is_alacarte
      ShopUsage.find_by(shop: self.shop, reservation_category: self.reservation_category)&.price
    end
  end

  def sum_price
    unless is_alacarte
      output_price * (people_count - 1) # -1は幹事分
    end
  end

  def tax_included_price
    unless is_alacarte
      (sum_price * 1.08).floor # TODO: 消費税をどこかで定数化する
    end
  end

  def setting_payment(params=nil)
    payment = build_reservation_payment(params)
    payment.user = user
    payment.limited_on = 1.week.since # TODO: 決済日付が決定次第変更可能性あり
    payment
  end

  def can_change?
    applying? || remand? || done?
  end

  def unsettled_price?
    visited? && reservation_payment.blank?
  end

  def unpayment?
    (reservation_payment.present? && reservation_payment.requested?) || visited?
  end

  private

  def delete_reservation_category_when_alacarte
    if is_alacarte
      reservation_category_id = nil
    end
  end
end
