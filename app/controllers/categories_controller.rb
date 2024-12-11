class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @pages = @category.pages.order(created_at: :desc).limit(5)
    @page_posts = PagePost.joins(page: :category).where(categories: { id: @category.id }).order(created_at: :desc).limit(5)
  end
end
