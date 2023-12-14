class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @booking = Booking.find(params[:booking_id])
  end

  def create
    booking = Booking.find(params[:booking_id])
    tour = booking.tour

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: tour.title,
            description: tour.description,
          },
          unit_amount: tour.price * 100,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    )

    redirect_to 
  end
end