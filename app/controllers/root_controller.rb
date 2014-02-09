class RootController < ApplicationController
  def index
    
    @users = User.all
  end

  def about
  end

  def home
  end

  def profile
  end
end
