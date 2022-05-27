class Report < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe
  validates_uniqueness_of :recipe_id, scope: :customer_id
end
