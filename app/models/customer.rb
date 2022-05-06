class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :customer_image
  
  def get_customer_image(width, height)
  unless customer_image.attached?
    file_path = Rails.root.join('app/assets/images/no.jpg')
    customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  customer_image.variant(resize_to_limit: [width, height]).processed
  end

end
