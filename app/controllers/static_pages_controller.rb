class StaticPagesController < ApplicationController
  # before_action :load_tour, only: %i(home)
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

  def list_tour
    @list_tour = ListTour.find(params[:id]) # or however you are retrieving the ListTour
    @categories = Category.all
    @tours = @list_tour.tour.all
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
end

