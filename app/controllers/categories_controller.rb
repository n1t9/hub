class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @keywords = @category.keywords
    @pages = Page.joins(:page_keywords).where(page_keywords: { keyword_id: @keywords.pluck(:id) }).distinct.order(:updated_at).page(params[:page]).per(10)
  end
end
