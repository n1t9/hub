class OfficialPostsController < ApplicationController
  def index
    @official_posts = OfficialPost.order(created_at: :desc).page(params[:page])
  end

  def show
    @official_post = OfficialPost.find(params[:id])
  end

  def new
    return redirect_to root_path unless current_user&.is_admin

    @official_post = OfficialPost.new
  end

  def create
    return redirect_to root_path unless current_user&.is_admin

    @official_post = OfficialPost.new(official_post_params)

    if @official_post.save
      flash[:success] = t("flash.post")
      redirect_to official_post_path(@official_post)
    else
      flash[:error] = @official_post.errors.full_messages
      render :new
    end
  end

  def edit
    return redirect_to root_path unless current_user&.is_admin

    @official_post = OfficialPost.find(params[:id])
  end

  def update
    return redirect_to root_path unless current_user&.is_admin

    @official_post = OfficialPost.find(params[:id])

    if @official_post.update(official_post_params)
      flash[:success] = t("flash.update")
      redirect_to official_post_path(@official_post)
    else
      flash[:error] = @official_post.errors.full_messages
      render :edit
    end
  end

  def destroy
    return redirect_to root_path unless current_user&.is_admin

    @official_post = OfficialPost.find(params[:id])
    @official_post.destroy
    flash[:success] = t("flash.destroy")
    redirect_to official_posts_path
  end

  private

  def official_post_params
    params.require(:official_post).permit(:title, :cover_image, :content, category_ids: [])
  end
end
