class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  # Association
  has_many :reservation

  # Validation
  validates :l_name, presence: true
  validates :f_name, presence: true
  validates :l_name_kana, presence: true
  validates :f_name_kane, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9-]+\z/, message: "電話番号は数字、ハイフンのみ入力できます。"}
  validates :bank_name, presence: true
  validates :bank_branch_name, presence: true
  validates :bank_account_number, presence: true

  # 全角を半角に変換
  def phone_number=(value)
    value.tr!('０-９ー','0-9-') if value.is_a?(String)
    super(value)
  end

  # FaceBookログイン用
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.new(
        email: auth.info.email
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end
end
