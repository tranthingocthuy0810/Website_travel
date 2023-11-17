class Post < ApplicationRecord
    belongs_to :user, optional: true
    validates :title, presence: true
    validates :discription, presence: true
    enum status: {draft: 0, published: 1}

end
