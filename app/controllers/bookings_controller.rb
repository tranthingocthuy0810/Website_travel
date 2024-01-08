class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tour = Tour.find(params[:tour_id])
    @booking = Booking.new
    @session = stripe_session
  end

  def create
    booking_params = params.require(:booking).permit(:start_date, :end_date, :tour_id, :number_person)
    @tour = Tour.find(booking_params[:tour_id])
    @booking = current_user.bookings.build(booking_params.merge(tour: @tour))
    @session = stripe_session
  
    if @booking.valid?
      # Debug output
      puts "Booking is valid!"
    else
      # Debug output
      puts "Booking is invalid!"
      puts "Errors: #{@booking.errors.full_messages}"
    end
  
    if @booking.save
      flash[:notice] = 'Booking created successfully.'
      respond_to do |format|
        format.js
      end
    else
      flash.now[:alert] = @booking.errors.full_messages.join(', ')
      render 'new'
    end
  end

  private

  def stripe_session
    number_person = @booking.number_person || 1

    total_amount = @tour.price * number_person
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
          unit_amount: total_amount,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    )
  end

  def success
  end
end