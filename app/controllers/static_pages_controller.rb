class StaticPagesController < ApplicationController
  # before_action :load_tour, only: %i(home)
  before_action :load_tour_status, only: %i(home)
  def home
    @tours = policy_scope(Tour)
    @categories = Category.all
    @list_tours = ListTour.all
  end

  def show
    @tour = Tour.find(params[:id])
    @list_tour = @tour.list_tour
    show_recommendations(tour_id: @tour.id)
  end
  
  def help
  end

  def show_tour
    @tour = Tour.find_by(params[:id])
    @list_tour = @tour.list_tour
    @tours = filtered_tours.paginate(page: params[:page], per_page: 10)
  end

  def load_tour_status
    @tours_all_hot = Tour.where(status: "hot").sort_by_created.limit(6)
    @tours_all_popular = Tour.where(status: "popular").sort_by_created.limit(6)
    @tours_all_trend = Tour.where(status: "trend").sort_by_created.limit(6)
    return if @tours_all_hot && @tours_all_popular && @tours_all_trend

    flash[:danger] = t "flash.product_not_found"
    redirect_to root_path
  end

  def show_recommendations(tour_id:)
    # If tour_id is not provided, return an empty array
    return @tour_recommendations = [] unless tour_id.present?
  
    # Make the API request with the tour ID
    api_url = "http://127.0.0.1:5000/recommendations?tour_id=#{tour_id}"
    uri = URI.parse(api_url)
    response = Net::HTTP.get_response(uri)
  
    if response.is_a?(Net::HTTPSuccess)
      # Process the API response and get product recommendations
      tour_recommendations_data = JSON.parse(response.body)['recommendations']
  
      puts "API Response: #{response.body}" # Add this line for debugging
  
      # Get the product IDs from the recommendation data
      tour_ids = tour_recommendations_data.map { |recommendation| recommendation['id'] } # Use 'id' instead of 'tour_id'
  
      # Filter out nil values from the array
      tour_ids.reject!(&:nil?)
  
      puts "Tour IDs from API: #{tour_ids}" # Add this line for debugging
      # Find the corresponding products in the database
      @tour_recommendations = Tour.where(id: tour_ids)
      puts "All Tour IDs in the database: #{Tour.pluck(:id)}"
    else
      # Handle errors
      puts "API Error: #{response.code} - #{response.body}" # Add this line for debugging
      @tour_recommendations = [] # Or display an error message
    end
  end

  private

  def filtered_tours
    tours = @list_tour.tours

    if params[:search].present?
      # Assuming 'title' is the attribute you want to search on
      tours = tours.where('title ILIKE ?', "%#{params[:search]}%")
    end

    tours
  end
end

