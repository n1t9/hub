class PagesController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @pages = @category.pages.order(updated_at: :desc).page(params[:page]).per(10)
    else
      @pages = Page.order(updated_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @page = Page.find(params[:id])
    @tab = params[:tab]? params[:tab] : "top"
    if @tab == "top"
      @page_posts = @page.page_posts.order(created_at: :desc).limit(5)
      @page_reviews = @page.page_reviews.order(created_at: :desc).limit(5)
    elsif @tab == "posts"
      @page_posts = @page.page_posts.order(created_at: :desc).page(params[:page]).per(10)
    elsif @tab == "reviews"
      @page_reviews = @page.page_reviews.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def new
    @page = current_user.pages.build
  end

  def create
    @page = current_user.pages.build(page_params)
    if @page.save
      current_user.page_managers.create(page_id: @page.id, role: 1)
      flash[:success] = "ページを作成しました"
      redirect_to page_path(@page)
    else
      flash[:error] = @page.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @page = Page.find(params[:id])
    redirect_to page_path(params[:id]) unless current_user&.page_manager?(@page)
  end

  def update
    @page = Page.find(params[:id])
    return redirect_to page_path(params[:id]) unless current_user&.page_manager?(@page)

    if @page.update(page_params)
      flash[:success] = "ページを更新しました"
      redirect_to page_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    return redirect_to page_path(params[:id]) unless current_user&.page_manager?(@page)

    @page.destroy
    flash[:success] = "ページを削除しました"
    redirect_to root_path
  end

  private

  def page_params
    params.require(:page).permit(:category_id, :name, :profile_image, :url, :bio)
  end
end
