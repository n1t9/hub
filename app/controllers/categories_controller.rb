class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @keywords = @category.keywords.order(:sequence)
    @pages = Page.joins(:page_keywords).where(page_keywords: { keyword_id: @keywords.pluck(:id) }).distinct.order(:updated_at).limit(10)
  end
end
