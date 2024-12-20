class PagePosts::BookmarksController < ApplicationController
  def create
    @page_post = PagePost.find(params[:page_post_id])
    @bookmark = current_user.page_post_bookmarks.build(page_post: @page_post)
    if @bookmark.save
      flash.now[:info] = t("flash.create")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @page_post }
      end
    else
      flash.now[:error] = t("flash.failed")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @page_post }
      end
    end
  end

  def destroy
    @page_post = PagePost.find(params[:page_post_id])
    @bookmark = current_user.page_post_bookmarks.find_by(page_post_id: params[:page_post_id])
    @bookmark.destroy
    flash.now[:info] = t("flash.destroy")
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @page_post }
    end
  end
end
