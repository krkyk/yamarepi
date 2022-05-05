class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :customer_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
