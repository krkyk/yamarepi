class ForumComment < ApplicationRecord
  belongs_to :customer
  belongs_to :forum

  validates :forum_comment, presence: true, length: { maximum: 100 }
end
