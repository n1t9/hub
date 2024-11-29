class OfficialPosts::BookmarksController < ApplicationController
  def create
    official_post = OfficialPost.find(params[:official_post_id])
    bookmark = current_user.official_post_bookmarks.build(official_post:)
    if bookmark.save
      flash[:info] = t("flash.create")
      redirect_to session.delete(:return_to)
    else
      flash[:error] = t("flash.failed")
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    bookmark = current_user.official_post_bookmarks.find_by(official_post_id: params[:official_post_id])
    bookmark.destroy
    flash[:info] = t("flash.destroy")
    redirect_to session.delete(:return_to)
  end
end
