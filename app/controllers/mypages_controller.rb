class MypagesController < ApplicationController
  def index
    return redirect_to root_path unless current_user

    @pages = current_user.pages.order(created_at: :desc)
  end
end
