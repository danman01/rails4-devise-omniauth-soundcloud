class User < ActiveRecord::Base

  has_many :identities
  has_one :user_setting

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # nice urls
  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.from_omniauth(auth)
    joins(:identities).where(identities: auth.slice(:provider, :uid)).first_or_create do |user|
      user.identities.build(provider: auth.provider, uid: auth.uid)
      user.username = auth.info.nickname
    end
  end

end
