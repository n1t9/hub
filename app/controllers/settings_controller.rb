class SettingsController < ApplicationController
  def show
    redirect_to root_path unless current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = t("flash.update")
      redirect_to settings_path
    else
      flash[:error] = current_user.errors.full_messages.join(", ")
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio)
  end
end
