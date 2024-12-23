class HomeController < ApplicationController
  def index
    redirect_to signup_setup_path if current_user && !current_user.setup?

    @categories = Category.order(:sequence)
    @page_posts = PagePost.order(created_at: :desc).limit(5)
    @official_posts = OfficialPost.order(created_at: :desc).limit(5)
    if current_user
      @following_pages = current_user.following_pages.order(updated_at: :desc).limit(5)
      @following_page_posts = PagePost.where(page_id: current_user.following_pages.pluck(:id)).order(created_at: :desc).limit(5)
    end
  end
end
