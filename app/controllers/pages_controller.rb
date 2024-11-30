class PagesController < ApplicationController
  def index
    @genre = params[:genre]? params[:genre].to_i : 1
    pages = Page.where(genre: @genre)
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @pages = pages.joins(:page_keywords).where(page_keywords: { keyword_id: @category.keywords.pluck(:id) }).distinct.order(:updated_at).page(params[:page]).per(10)
    else
      @pages = pages.order(:updated_at).page(params[:page]).per(10)
    end
  end

  def show
    @page = Page.find(params[:id])
    @tab = params[:tab]? params[:tab] : "top"
    if @tab == "top"
      @page_posts = @page.page_posts.order(updated_at: :desc).limit(5)
      @page_reviews = @page.page_reviews.order(updated_at: :desc).limit(5)
    elsif @tab == "posts"
      @page_posts = @page.page_posts.order(updated_at: :desc).page(params[:page]).per(10)
    elsif @tab == "reviews"
      @page_reviews = @page.page_reviews.order(updated_at: :desc).page(params[:page]).per(10)
    end
  end

  def edit
    @page = Page.find(params[:id])
    redirect_to page_path(params[:id]) unless @page.users.include?(current_user)
  end

  def update
    @page = Page.find(params[:id])
    return redirect_to page_path(params[:id]) unless @page.users.include?(current_user)

    if @page.update(page_params)
      redirect_to page_path(params[:id])
    else
      render :edit
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :bio)
  end
end
