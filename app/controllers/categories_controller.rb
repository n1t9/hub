class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @keywords = @category.keywords.order(:sequence)
    @civilian_pages = Page.joins(:page_keywords).where(genre: 1, page_keywords: { keyword_id: @keywords.pluck(:id) }).distinct.order(:updated_at).limit(5)
    @government_pages = Page.joins(:page_keywords).where(genre: 2, page_keywords: { keyword_id: @keywords.pluck(:id) }).distinct.order(:updated_at).limit(5)
    @page_posts = PagePost.joins(:page).where(page_id: @civilian_pages.map(&:id) + @government_pages.map(&:id)).order(created_at: :desc).limit(5)
  end
end
