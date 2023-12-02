class Category < ApplicationRecord
    has_many :list_tour, dependent: :destroy
    validates :tourname, presence: true
end
