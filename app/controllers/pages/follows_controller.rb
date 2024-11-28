class Pages::FollowsController < ApplicationController
  def create
    page = Page.find(params[:page_id])
    page_follower = page.page_followers.new(user: current_user)
    if page_follower.save
      flash[:success] = t("flash.update")
      redirect_to page_path(page)
    else
      flash[:error] = t("flash.failed")
      redirect_to page_path(page)
    end
  end

  def destroy
    page = Page.find(params[:page_id])
    page_follower = page.page_followers.find_by(user: current_user)
    if page_follower.destroy
      flash[:success] = t("flash.update")
      redirect_to page_path(page)
    else
      flash[:error] = t("flash.failed")
      redirect_to page_path(page)
    end
  end
end
