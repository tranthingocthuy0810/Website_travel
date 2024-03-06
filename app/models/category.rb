class Category < ApplicationRecord
    has_many :list_tours, dependent: :destroy
    has_many :tours
    validates :tourname, presence: true
end
