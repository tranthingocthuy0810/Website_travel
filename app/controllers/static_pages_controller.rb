class StaticPagesController < ApplicationController
  def home
    @tours = policy_scope(Tour)
    @categories = Category.all
    @list_tours = ListTour.all
  end

  def show
    @tour = Tour.find(params[:id])
    @list_tour = ListTour.find(params[:id])
  end
  
  def help
  end

  def list_tour
    @list_tour = ListTour.find(params[:id]) # or however you are retrieving the ListTour
    @categories = Category.all
    @tours = @list_tour.tour.all
  end
end

