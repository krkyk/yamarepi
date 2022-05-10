class Comment < ApplicationRecord

  belongs_to :customer
  belongs_to :recipe

  has_one_attached :comment_image

  def get_comment_image(width, height)
  unless comment_image.attached?
    file_path = Rails.root.join('app/assets/images/noimage.jpg')
    comment_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    comment_image.variant(resize_to_limit: [width, height]).processed
  end

end
