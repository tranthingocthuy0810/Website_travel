class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  validates :start_date, :end_date, presence: true
end
