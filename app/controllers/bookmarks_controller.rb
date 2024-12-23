class BookmarksController < ApplicationController
  def index
    return redirect_to root_path unless current_user

    @tab = params[:tab]? params[:tab] : "page_posts"
    if @tab == "page_posts"
      @page_posts = PagePost.where(id: current_user.page_post_bookmarks.pluck(:page_post_id)).order(created_at: :desc).page(params[:page]).per(10)
    elsif @tab == "official_posts"
      @official_posts = OfficialPost.where(id: current_user.official_post_bookmarks.pluck(:official_post_id)).order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end
