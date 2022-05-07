class RecipeTag < ApplicationRecord

  belongs_to :recipe
  belongs_to :tags

end
