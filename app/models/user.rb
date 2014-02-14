class User < ActiveRecord::Base

  has_many :identities, :dependent=>:destroy
  has_one :user_setting

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # create virtual attributes
  attr_accessor :login

  # validate the user object. Calling user.valid? and then user.errors will display validation errors
  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  # perform this action after the user is created
  after_create :assign_role

  # nice urls (turns /something/55 into /something/name-of-record)
  extend FriendlyId
  friendly_id :username, use: :slugged

  # set up roles for this class. Use like user.has_role?("admin"), or add a role with user.add_role!("admin")
  easy_roles :roles

  # Called from the omniauth callback controller. Note: some of this is specific to Soundcloud, like profile_url, info_hash...
  #
  # Returns the existing or newly created user along with the identity found or built
  def self.from_omniauth(auth)
    provider =  auth.provider
    uid = auth.uid.to_s
    # Use select("*") to get around the readonly: true default setting when using join
    #user_to_return = select('*').joins(:identities).where(identities: {provider: provider, uid: uid}).first
    identity = Identity.where(provider: provider, uid: uid).first rescue nil
    if identity
      user_to_return = identity.user
    else
      # no identity exists...create new user for this identity
      user = User.new
      # build the associated identity for this provider, first converting the auth info to an encoded json object
      auth_hash = ActiveSupport::JSON.encode(auth.to_hash) rescue auth.to_s
      identity = user.identities.build(provider: provider, uid: uid, info_hash:auth_hash, profile_url: auth.extra.raw_info.uri)
      # update user attributes based on what we grab
      user = user.update_user_from_auth(auth)
      user.save # attempt to persist user
      user_to_return = user
    end
    return [user_to_return, identity]
  end

  # Override Devise method to allow session to be carried over to new user registration form
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      # we already trust this isn't mass assignment attack, so use without protection
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.identities.build(session["identity_attributes"]) if session["identity_attributes"]
        # sets user.errors, which will be present when we return the user to the form with validation errors
        user.valid?
      end
    else
      # create and return new User instance
      super
    end    
  end


  # Over riding devise method found in devise/lib/devise/models/database_authenticatable.rb
  # Allows omniauth account finding by virtual attribute, login, which is either username or email
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # If user authenticates without a password, do not require their password to udpate attributes
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  # Require a password unless user has associated Identity
  def password_required?
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

  private

    # Assign the user role to the new user
    def assign_role
      self.add_role!("user")
    end

end
