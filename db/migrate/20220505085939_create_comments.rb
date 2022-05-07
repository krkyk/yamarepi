class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id
      t.integer :recipe_id
      t.string :comment

      t.timestamps
    end
  end
end
