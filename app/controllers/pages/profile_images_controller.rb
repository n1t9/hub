class Pages::ProfileImagesController < ApplicationController
  def show
    @page = Page.find(params[:page_id])
    return redirect_to page_path(params[:page_id]) unless @page.users.include?(current_user)

    @profile_image = @page.display_profile_image
  end

  def create
    @page = Page.find(params[:page_id])
    return redirect_to page_path(params[:page_id]) unless @page.users.include?(current_user)

    if @page.update(profile_image: params[:profile_image])
      flash[:success] = t("flash.update")
      redirect_to edit_page_path(@page)
    else
      flash[:alert] = t("flash.update_failed")
      render :show, status: :unprocessable_entity
    end
  end
end
