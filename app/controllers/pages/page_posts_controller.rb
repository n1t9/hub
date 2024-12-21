class Pages::PagePostsController < ApplicationController
  def new
    @page = Page.find(params[:page_id])
    return redirect_to page_path(params[:page_id]) unless current_user&.page_manager?(@page)

    @page_post = @page.page_posts.build
  end

  def create
    @page = Page.find(params[:page_id])
    return redirect_to page_path(params[:page_id]) unless current_user&.page_manager?(@page)

    @page_post = @page.page_posts.build(page_post_params)
    if @page_post.save
      flash[:success] = t("flash.post")
      redirect_to page_path(@page)
    else
      flash[:alert] = @page_post.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def page_post_params
    params.require(:page_post).permit(:title, :cover_image, :content)
  end
end
