class Step < ApplicationRecord

  belongs_to :recipe
  
  validates :step_description, presence: true

end
