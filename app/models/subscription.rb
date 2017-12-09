class Subscription < ApplicationRecord
  belongs_to :user

  enum status: { cancel: 0, trial: 1, active: 2, examption: 3 }

  validates :customer_id, presence: true

  # TODO: PayjpApiの呼び出しを後でリファクタリング
  def create_record(token)
    payjp_api = PayjpApi.new
    self.customer_id = payjp_api.create_customer(token).id
    self.save
  end
end
