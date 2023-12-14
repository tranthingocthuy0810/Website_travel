class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tour = Tour.find(params[:tour_id])
    @booking = Booking.new
  end

  def create
    booking_params = params.require(:booking).permit(:start_date, :end_date, :tour_id)
    @tour = Tour.find(booking_params[:tour_id])
    @booking = current_user.bookings.build(booking_params.merge(tour: @tour))

    if @booking.save
      session_id = stripe_session.id
      render json: { success: true, session_id: session_id }
    else
      render json: { success: false, error_message: "Booking failed" }
    end
  end

  private

  def stripe_session
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: @tour.title,
            description: @tour.description,
          },
          unit_amount: @tour.price * 100,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    )
  end
end