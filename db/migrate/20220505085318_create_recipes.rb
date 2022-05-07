class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :serving
      t.string :description
      t.integer :customer_id

      t.timestamps
    end
  end
end
