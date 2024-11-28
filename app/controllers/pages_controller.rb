class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
    redirect_to page_path(params[:id]) unless @page.users.include?(current_user)
  end

  def update
    @page = Page.find(params[:id])
    return redirect_to page_path(params[:id]) unless @page.users.include?(current_user)

    if @page.update(page_params)
      redirect_to page_path(params[:id])
    else
      render :edit
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :bio)
  end
end
