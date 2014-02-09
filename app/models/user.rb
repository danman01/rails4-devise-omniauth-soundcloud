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

  # Called from the omniauth callback controller
  #
  # Returns the existing or newly created user
  def self.from_omniauth(auth)
    provider =  auth.provider
    uid = auth.uid.to_s
    joins(:identities).where(identities: {provider: provider, uid: uid}).first_or_create do |user|
      user.identities.build(provider: provider, uid: uid, info_hash:auth)
      user = user.update_user_from_auth(auth)
    end
  end

  # Override Devise method to allow session to be carried over to new user registration form
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      # we already trust this isn't mass assignment attack, so use without protection
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        # will return the user to the form with validation errors
        user.valid?
      end
    else
      # create and return new User instance
      super
    end    
  end

  # If user is not updating their password, do not require their password
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  # Require a password unless user has associated Identity
  def password_required?
    debugger
    super && identities.empty? # doesn't have any associated identities
  end

  # Given info_auth from somewhere like Soundcloud, update / fill in user attributes
  #
  # Returns user
  def update_user_from_auth(auth)
    user = self
    user.username = auth.info.nickname
    user.avatar_url = auth.info.image
    user.location = auth.extra.raw_info.city
    user.country = auth.extra.raw_info.country
    user.name = auth.info.name
    user
  end

end
