class Pages::ManagersController < ApplicationController
  # only admin can access this controller
  before_action :require_admin

  def show
    @page = Page.find(params[:page_id])
    @users = @page.managers
  end

  def new
    @page = Page.find(params[:page_id])
    @users = User.where.not(id: @page.managers.pluck(:id))
  end

  def create
    @page = Page.find(params[:page_id])
    @user = User.find(params[:user_id])
    if @page.page_managers.create(user: @user, role: :member)
      flash[:success] = t("flash.create")
    else
      flash[:error] = @page.errors.full_messages.join(", ")
    end
    redirect_to page_managers_path(@page)
  end

  def destroy
    @page = Page.find(params[:page_id])
    @user = User.find(params[:id])
    if @page.managers.delete(@user)
      flash[:success] = t("flash.destroy")
    else
      flash[:error] = @page.errors.full_messages.join(", ")
    end
    redirect_to page_managers_path(@page)
  end

  private

  def require_admin
    redirect_to root_path unless current_user.is_admin
  end
end
