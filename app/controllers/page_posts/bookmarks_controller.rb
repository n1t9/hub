class PagePosts::BookmarksController < ApplicationController
  def create
    page_post = PagePost.find(params[:page_post_id])
    bookmark = current_user.page_post_bookmarks.build(page_post:)
    if bookmark.save
      flash[:info] = t("flash.create")
      redirect_to session.delete(:return_to)
    else
      flash[:error] = t("flash.failed")
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    bookmark = current_user.page_post_bookmarks.find_by(page_post_id: params[:page_post_id])
    bookmark.destroy
    flash[:info] = t("flash.destroy")
    redirect_to session.delete(:return_to)
  end
end
