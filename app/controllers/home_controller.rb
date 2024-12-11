class HomeController < ApplicationController
  def index
    redirect_to signup_setup_path if current_user && !current_user.setup?

    session[:return_to] = request.url
    @categories = Category.order(:sequence)
    @page_posts = PagePost.order(created_at: :desc).limit(5)
    @official_posts = OfficialPost.order(created_at: :desc).limit(5)
  end
end
