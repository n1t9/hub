class MypagesController < ApplicationController
  def index
    return redirect_to root_path unless current_user

    @pages = current_user.pages.order(updated_at: :desc).page(params[:page]).per(10)
  end
end
