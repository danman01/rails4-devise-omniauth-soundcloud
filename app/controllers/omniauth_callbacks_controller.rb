class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # We can define an action for each provider that we want to support but the logic for each different type of provider is pretty similar 
  # so instead of creating an action for each provider we create a single action called all and use alias_method to point each provider to this action
  def all
    #raise request.env["omniauth.auth"].to_yaml
    # find or create user
    user = User.from_omniauth(request.env["omniauth.auth"])
    debugger
    if user.persisted?
      flash[:notice] = "Signed in!"
      sign_in_and_redirect user
    else
      @user = user
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url, notice: "Please finish creating your account"
    end
  end
  alias_method :soundcloud, :all
end
