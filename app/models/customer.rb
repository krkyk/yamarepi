class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes ,dependent: :destroy
  has_many :favorites ,dependent: :destroy
  has_many :comments ,dependent: :destroy
  has_many :reports ,dependent: :destroy
  
  validates :name, length: { in: 2..20 }, uniqueness: true

  has_one_attached :customer_image

  def get_customer_image(width, height)
  unless customer_image.attached?
    file_path = Rails.root.join('app/assets/images/noimage.jpg')
    customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    customer_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = 'ゲストユーザー'
      customer.email = 'guest@example.com'
    end
  end

end
