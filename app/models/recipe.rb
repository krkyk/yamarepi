class Recipe < ApplicationRecord

  belongs_to :customer
  #親がまだ保存されていない状態で子モデルの中身を保存するためinverse_ofを使用
  has_many :ingredients ,inverse_of: :recipe ,dependent: :destroy
  #accepts_nested_attributes_forで親子モデル両方にデータを送信できる
  #allow_destroy: trueで子モデルの削除が可能
  accepts_nested_attributes_for :ingredients
  has_many :steps ,inverse_of: :recipe ,dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
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

  def favorited_by?(customer)
    favorites.exists?(customer_id:customer.id)
  end

end
