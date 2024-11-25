class HomeController < ApplicationController
  def index
    redirect_to signup_setup_path if current_user && !current_user.setup?

    session[:return_to] = request.url
    @categories = Category.includes(:keywords).order(:id)
    @pages = Page.order(created_at: :desc).limit(5)
    @page_posts = PagePost.order(created_at: :desc).limit(5)
  end
end
