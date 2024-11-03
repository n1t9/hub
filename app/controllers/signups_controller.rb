class SignupsController < ApplicationController
  def show
    redirect_to root_path if current_user

    @user = User.new
  end

  def create
    redirect_to root_path if current_user

    @user = User.new(signup_params)
    if @user.save
      create_session(@user)
      @user.send_verification_email
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity, alert: "There was an error creating your account."
    end
  end

  private

    def signup_params
      params.require(:user).permit(:email, :password)
    end
end
