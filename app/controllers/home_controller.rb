class HomeController < ApplicationController
  def index
    redirect_to signup_setup_path if current_user && !current_user.setup?
  end
end
