class KeywordsController < ApplicationController
  def show
    @genre = params[:genre]? params[:genre].to_i : 1
    @keyword = Keyword.find(params[:id])
    @pages = @keyword.pages.where(genre: @genre).order(updated_at: :desc).page(params[:page])
  end
end
