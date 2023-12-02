class Tour < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :list_tour
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0}
    has_one_attached :image
    enum status: { draft: 'draft', published: 'published', approval: 'approval' }
end
