class ForumComment < ApplicationRecord
  belongs_to :customer
  belongs_to :forum
end
