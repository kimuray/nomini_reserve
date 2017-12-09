class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  # Association
  has_many :reservations
  has_many :reservation_benefits
  has_many :reservation_payments, dependent: :destroy
  has_many :exchanges
  has_many :introductions, dependent: :destroy
  has_one :bank_account, dependent: :destroy
  has_one :subscription
  has_one :passive_introduction, class_name: "Introduction",
                                 foreign_key: "introduced_user_id",
                                 dependent: :destroy

  # Validation
  validates :l_name_kana, presence: true, format: { with: /\A[ァ-ンー－]+\z/, message: "フルネームは全角カタカナで入力してください。"}, unless: :new_record?
  validates :f_name_kana, presence: true, format: { with: /\A[ァ-ンー－]+\z/, message: "フルネームは全角カタカナで入力してください。"}, unless: :new_record?
  validates :phone_number, presence: true, format: { with: /\A[0-9]+\z/, message: "電話番号は数字のみで入力してください。"}, unless: :new_record?

  # 全角を半角に変換
  def phone_number=(value)
    value.tr!('０-９','0-9') if value.is_a?(String)
    super(value)
  end

  # FaceBookログイン用
  def self.find_for_facebook_oauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.skip_confirmation!
    end
  end

  # providerがある（Facebook経由で認証した）場合は、
  # passwordは要求しないようにする。
  def password_required?
    super && provider.blank?
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  def full_name
    "#{l_name} #{f_name}"
  end

  def full_name_kana
    "#{l_name_kana} #{f_name_kana}"
  end

  def add_monthly_usage_amount!(amount)
    sum = monthly_usage_amount + amount
    update!(monthly_usage_amount: sum)
  end
end
