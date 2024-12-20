class OfficialPosts::BookmarksController < ApplicationController
  def create
    @official_post = OfficialPost.find(params[:official_post_id])
    @bookmark = current_user.official_post_bookmarks.build(official_post: @official_post)
    if @bookmark.save
      flash.now[:info] = t("flash.create")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @official_post }
      end
    else
      flash.now[:error] = t("flash.failed")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @official_post }
      end
    end
  end

  def destroy
    @official_post = OfficialPost.find(params[:official_post_id])
    @bookmark = current_user.official_post_bookmarks.find_by(official_post_id: params[:official_post_id])
    @bookmark.destroy
    flash.now[:info] = t("flash.destroy")
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @official_post }
    end
  end
end
