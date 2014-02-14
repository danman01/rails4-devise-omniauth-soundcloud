class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # We can define an action for each provider that we want to support but the logic for each different type of provider is pretty similar 
  # so instead of creating an action for each provider we create a single action called all and use alias_method to point each provider to this action
  def all
    #raise request.env["omniauth.auth"].to_yaml
    # find or create user
    @user, identity = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = "Signed in!"
      binding.pry
      sign_in_and_redirect @user, :event=> :authentication # TODO user is not in session...?
    else
      session["devise.user_attributes"] = @user.attributes
      session["identity_attributes"] = identity.attributes
      flash[:success] = "Please finish creating your account"
      redirect_to new_user_registration_url
    end
  end
  alias_method :soundcloud, :all
end
