class SearchesController < ApplicationController
  def show
    @tasks = Task.where("description LIKE '%#{params[:search]}%'")
  end
end
