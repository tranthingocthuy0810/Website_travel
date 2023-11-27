class CheckoutsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      tour = Tour.find(params[:id])
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
        price_data: {
            currency: 'usd',
            product_data: {
            name: tour.title,
            },
            unit_amount: tour.price, 
        },
        quantity: 1,
        }],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
  
      respond_to do |format|
        format.js
      end
    end
  end