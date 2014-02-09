class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # We can define an action for each provider that we want to support but the logic for each different type of provider is pretty similar 
  # so instead of creating an action for each provider we create a single action called all and use alias_method to point each provider to this action
  def all
    raise request.env["omniauth.auth"].to_yaml
  end
  alias_method :soundcloud, :all
end
