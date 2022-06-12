class Attention < ApplicationRecord
  belongs_to :customer
  belongs_to :forum
  validates_uniqueness_of :forum_id, scope: :customer_id
end
