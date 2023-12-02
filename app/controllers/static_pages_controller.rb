class StaticPagesController < ApplicationController
  def home
    @tours = policy_scope(Tour)
    @categories = Category.all
  end

  def show
    @tour = Tour.find(params[:id])
  end
  
  def help
  end
end

