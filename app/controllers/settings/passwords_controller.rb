class Settings::PasswordsController < ApplicationController
  def show
    redirect_to root_path unless current_user
  end

  def update
    if current_user.authenticate(params[:current_password]) && params[:password] == params[:password_confirmation]
      current_user.update(password: params[:password])
      flash[:success] = "パスワードを変更しました"
      redirect_to settings_password_path
    else
      flash.now[:alert] = "パスワードが一致しない、または現在のパスワードが間違っています"
      render :show
    end
  end
end
