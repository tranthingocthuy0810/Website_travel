class Tour < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :list_tour
    has_many :bookings
    # validates :title, presence: true, uniqueness: true
    # validates :description, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    has_one_attached :image
    enum status: { popular: 'popular', hot: 'hot', trend: 'trend' }
    scope :sort_by_created, -> { order(created_at: :desc) }

    after_create do
        tour = Stripe::Product.create(name: title)
        price = Stripe::Price.create(product: tour.id, unit_amount: self.price, currency: "usd")
        update(stripe_tour_id: tour.id)
    end
end
