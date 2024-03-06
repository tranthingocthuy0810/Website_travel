class Admin::BookingsController < ApplicationController
  def index
    @bookings = Booking.all # hoặc thực hiện các truy vấn phức tạp hơn để lấy danh sách booking
  end
end