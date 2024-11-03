class SigninsController < ApplicationController
  def show
    redirect_to root_path if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_path if current_user

    @user = User.find_by(email: login_params[:email])
    if @user&.authenticate(login_params[:password])
      create_session(@user)
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity, alert: "There was an error logging in."
    end
  end


  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
