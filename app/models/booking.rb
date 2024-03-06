class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  validates :start_date, :end_date, :number_person, presence: true
  validates :number_person, numericality: { greater_than_or_equal_to: 1 }
  validate :dates_must_be_in_future

  private

  def dates_must_be_in_future
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, 'Ngày bắt đầu phải lớn hơn hoặc bằng thời gian hiện tại.')
    end
  
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, 'Ngày kết thúc phải lớn hơn hoặc bằng thời gian hiện tại.')
    end
  end
end