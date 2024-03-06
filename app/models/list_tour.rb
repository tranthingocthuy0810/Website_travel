class ListTour < ApplicationRecord
  belongs_to :category
  has_many :tours

  validates :name, presence: true, length: { maximum: 500 }
end
