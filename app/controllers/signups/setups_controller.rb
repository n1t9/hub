class Signups::SetupsController < ApplicationController
  def show
    redirect_to root_path unless current_user
  end

  def create
    if current_user.update(setup_params)
      flash[:success] = t("flash.setup")
      redirect_to root_path
    else
      flash[:error] = current_user.errors.full_messages.join(", ")
      render :show
    end
  end

  private

  def setup_params
    params.require(:user).permit(:name, :background)
  end
end
