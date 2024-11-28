class KeywordsController < ApplicationController
  def show
    @keyword = Keyword.find(params[:id])
    @pages = @keyword.pages
  end
end
