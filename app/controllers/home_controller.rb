class HomeController < ApplicationController
  def index
    redirect_to signup_setup_path if current_user && !current_user.setup?

    @categories = Category.includes(:keywords).order(:id)
    @pages = Page.all
    @posts = PagePost.all
  end
end
