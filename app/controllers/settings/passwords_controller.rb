class Settings::PasswordsController < ApplicationController
  def show
    redirect_to root_path unless current_user
  end

  def update
    if current_user.authenticate(params[:current_password]) && params[:password] == params[:password_confirmation]
      current_user.update(password: params[:password])
      flash[:success] = t("helpers.setting.change_password_success")
      redirect_to settings_password_path
    else
      flash[:error] = t("helpers.setting.change_password_failed")
      render :show, status: :unprocessable_entity
    end
  end
end
