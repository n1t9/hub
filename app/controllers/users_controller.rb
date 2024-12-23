class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def destroy
    redirect_to root_path unless current_user

    if params[:id].to_i == current_user.id
      current_user.destroy
      reset_session
      flash[:success] = t("flash.destroy")
      redirect_to root_path
    else
      flash[:error] = t("flash.failed")
      redirect_to user_path(current_user)
    end
  end
end
