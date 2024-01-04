class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tour = Tour.find(params[:tour_id])
    @booking = Booking.new
    @session = stripe_session
  end

  def create
    booking_params = params.require(:booking).permit(:start_date, :end_date, :tour_id)
    @tour = Tour.find(booking_params[:tour_id])
    @booking = current_user.bookings.build(booking_params.merge(tour: @tour))
    @session = stripe_session
  
    if @booking.save
      respond_to do |format|
        format.js
      end
    else
      render json: { success: false, error_message: "Booking failed" }
    end
  end

  private

  def stripe_session
    Stripe::Checkout::Session.create(
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: @tour.title,
            description: @tour.description,
          },
          unit_amount: @tour.price,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    )
  end
end
