class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
  
      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, Rails.application.credentials[:stripe][:webhook]
        )
      rescue JSON::ParserError => e
        status 400
        return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        puts "Signature error"
        p e
        return
      end
  
      # Handle the event
      case event.type
      when 'checkout.session.completed'
          session = event.data.object
          @tour = Tour.find_by(price: session.amount_total)    
          if @tour
            if @tour.increment!(:sales_count)
              puts "Sales count updated successfully."
            else
              puts "Failed to update sales count. Errors: #{@tour.errors.full_messages}"
            end
          else
            puts "Tour not found for price: #{session.amount_total}"
          end
      end
  
      render json: { message: 'success' }
    end
  end