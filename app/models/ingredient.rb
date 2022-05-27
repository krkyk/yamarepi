class Ingredient < ApplicationRecord
  belongs_to :recipe

  with_options presence: true do
    validates :content
    validates :quantity
  end
end
