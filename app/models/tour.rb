class Tour < ApplicationRecord
    belongs_to :user, optional: true
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    has_one_attached :image
    enum status: { draft: 'draft', published: 'published', approval: 'approval' }
end
