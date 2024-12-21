class PagePostsController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @page_posts = PagePost.includes(:page).where(pages: { category_id: @category.id }).order(created_at: :desc).page(params[:page]).per(10)
    else
      @page_posts = PagePost.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @page_post = PagePost.find(params[:id])
  end
end
