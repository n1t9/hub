class Signups::SetupsController < ApplicationController
  def show
    redirect_to root_path unless current_user
  end

  def create
    if current_user.update(setup_params)
      flash[:success] = t("flash.setup")
      redirect_to root_path
    else
      flash.now[:error] = current_user.errors.full_messages.join(", ")
      render :show, status: :bad_request
    end
  end

  private

  def setup_params
    params.require(:user).permit(:name, :display_name, :url, :profile_image, :background, :bio).tap do |p|
      p[:display_name] = p[:name] if p[:display_name].blank?
      p[:bio] = t("helpers.setup.bio") if p[:bio].blank?
    end
  end
end
