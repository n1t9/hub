class OfficialPostsController < ApplicationController
  def index
    @official_posts = OfficialPost.order(created_at: :desc).page(params[:page])
  end

  def show
    @official_post = OfficialPost.find(params[:id])
  end
end
