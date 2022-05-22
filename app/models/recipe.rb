class Recipe < ApplicationRecord

  belongs_to :customer
  # cocoon用：親がまだ保存されていない状態で子モデルの中身を保存するためinverse_ofを使用
  has_many :ingredients ,inverse_of: :recipe ,dependent: :destroy
  has_many :steps ,inverse_of: :recipe ,dependent: :destroy
  has_many :recipe_tags ,dependent: :destroy
  has_many :tags ,through: :recipe_tags
  has_many :favorites ,dependent: :destroy
  has_many :favorited_customers,through: :favorites, source: :customer
  has_many :comments ,dependent: :destroy
  has_many :reports ,dependent: :destroy
  has_many :reported_customers,through: :reports, source: :customer
  # cocoon用：accepts_nested_attributes_forで親子モデル両方にデータを送信できる
  # cocoon用：allow_destroy: trueで子モデルの削除が可能
  accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :steps, allow_destroy: true

  with_options presence: true do
    validates :title, length: { maximum: 15 }
    validates :serving
    validates :description, length: { maximum: 30 }
  end

  has_one_attached :recipe_image

  def get_recipe_image(width, height)
  unless recipe_image.attached?
    file_path = Rails.root.join('app/assets/images/noimage.jpg')
    recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    recipe_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def reported_by?(customer)
    reports.exists?(customer_id: customer.id)
  end

  scope:latest,->{order(created_at: :desc)}

  def self.recipe_favorites
    Recipe.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
  end

  def self.recipe_week_favorites
    to  = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    Recipe.includes(:favorited_customers).sort{|a,b|b.favorited_customers.includes(:favorites).where(favorites: {created_at: from...to}).size<=>
      a.favorited_customers.includes(:favorites).where(favorites: {created_at: from...to}).size}
  end

  def count_favorites_weekly
    self.favorites.where(favorites:{created_at: (Time.current - 6.day).at_beginning_of_day...Time.current.at_end_of_day}).count
  end

  def self.recipe_reports
    Recipe.includes(:reported_customers).sort {|a,b| b.reported_customers.size <=> a.reported_customers.size}
  end

end
