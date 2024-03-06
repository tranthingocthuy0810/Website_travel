class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  
  has_one_attached :avatar
  validates :phone_number, presence: true, length: { is: 10 }, numericality: { only_integer: true }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                                      format: { with: VALID_EMAIL_REGEX },
                                      uniqueness: true
  has_many :posts
  has_many :bookings
  after_commit :add_default_avatar, on: %i[create update]
  enum role: {user: 0, admin: 1, manager: 2}

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150!").processed
    else
      "/default.png"
    end
  end

  after_create do 
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private 
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            "app", "assets", "images", "default.png"
          )
        ), filename: "default.png",
        content_type: "image/png"
      )
    end
  end
end
