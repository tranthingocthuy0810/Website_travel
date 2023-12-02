class ListTour < ApplicationRecord
  belongs_to :category
  has_many :tour

  validates :name, presence: true, length: { maximum: 500 }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
