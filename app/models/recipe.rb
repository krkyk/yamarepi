class Recipe < ApplicationRecord

  belongs_to :customer
  has_many :recipe_ingredients ,dependent: :destroy
  has_many :ingredients ,through: :recipe_ingredients
  has_many :steps ,dependent: :destroy
  has_many :recipe_tags ,dependent: :destroy
  has_many :tags ,through: :recipe_tags
  has_many :favorites ,dependent: :destroy
  has_many :comments ,dependent: :destroy
  has_many :reports ,dependent: :destroy


  has_one_attached :recipe_image

  def get_recipe_image(width, height)
  unless recipe_image.attached?
    file_path = Rails.root.join('app/assets/images/noimage.jpg')
    recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  recipe_image.variant(resize_to_limit: [width, height]).processed
  end

end
