class DropRecipeIngredient < ActiveRecord::Migration[6.1]
  def change
    drop_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.string :quantity

      t.timestamps
    end
  end
end
