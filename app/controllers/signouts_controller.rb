class SignoutsController < ApplicationController
  def create
    reset_session
    flash[:success] = t("flash.signout")
    redirect_to root_path
  end
end
