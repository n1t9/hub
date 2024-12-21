class Pages::ReviewsController < ApplicationController
  def new
    @page = Page.find(params[:page_id])
    @page_review = @page.page_reviews.build
  end

  def create
    @page = Page.find(params[:page_id])
    @page_review = @page.page_reviews.build(page_review_params)
    @page_review.user = current_user
    if @page_review.save
      flash[:success] = t("flash.post")
      redirect_to @page
    else
      flash[:error] = @page_review.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @page = Page.find(params[:page_id])
    @page_review = @page.page_reviews.find_by(id: params[:id], user: current_user)
    unless @page_review
      redirect_to @page
    end
  end

  def update
    @page = Page.find(params[:page_id])
    @page_review = @page.page_reviews.find_by(id: params[:id], user: current_user)
    if @page_review && @page_review.update(page_review_params)
      flash[:success] = t("flash.update")
      redirect_to @page
    else
      flash[:error] = @page_review.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page = Page.find(params[:page_id])
    @page_review = @page.page_reviews.find(params[:id])
    if @page_review.user == current_user
      @page_review.destroy
      flash[:success] = t("flash.destroy")
      redirect_to @page
    else
      flash[:error] = @page_review.errors.full_messages.join(", ")
      redirect_to @page, status: :forbidden
    end
  end

  private

  def page_review_params
    params.require(:page_review).permit(:content)
  end
end
