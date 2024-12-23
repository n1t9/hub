class FollowingPagesController < ApplicationController
  def index
    return redirect_to root_path unless current_user

    @pages = Page.joins(:page_followers).where(page_followers: { user_id: current_user.id }).order(page_followers: { created_at: :desc }).page(params[:page]).per(10)
  end
end
