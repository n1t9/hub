class SignoutsController < ApplicationController
  def create
    reset_session
    redirect_to root_path
  end
end
