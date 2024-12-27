class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @pages = @category.pages.order(updated_at: :desc).limit(5)
    @page_posts = PagePost.joins(page: :category).where(categories: { id: @category.id }).order(created_at: :desc).limit(5)
    @official_posts = OfficialPost.joins(:categories).where(categories: { id: @category.id }).order(created_at: :desc).limit(5)
  end

  def edit
    @categories = Category.order(:sequence)
  end

  def update
    params[:categories].each do |category_id, category_params|
      category = Category.find(category_id)
      category.update(description: category_params[:description])
    end

    flash[:success] = "Successfully updated categories"
    redirect_to edit_categories_path
  end
end
