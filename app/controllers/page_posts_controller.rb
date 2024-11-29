class PagePostsController < ApplicationController
  def show
    @page_post = PagePost.find(params[:id])
  end
end
