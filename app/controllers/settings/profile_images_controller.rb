class Settings::ProfileImagesController < ApplicationController
  def show
    redirect_to root_path unless current_user
    @profile_image = current_user.display_profile_image
  end

  def create
    if current_user.update(profile_image: params[:profile_image])
      flash[:success] = t("flash.update")
      redirect_to settings_path
    else
      flash[:error] = t("flash.update_failed")
      render :show, status: :unprocessable_entity
    end
  end
end
