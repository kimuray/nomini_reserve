class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  # Association
  has_many :reservations
  has_many :apply_points
  has_one :bank_account, dependent: :destroy
  has_one :payment

  # Validation
  validates :l_name, presence: true
  validates :f_name, presence: true
  validates :l_name_kana, presence: true
  validates :f_name_kana, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9-]+\z/, message: "電話番号は数字、ハイフンのみ入力できます。"}

  # 全角を半角に変換
  def phone_number=(value)
    value.tr!('０-９ー','0-9-') if value.is_a?(String)
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
end
