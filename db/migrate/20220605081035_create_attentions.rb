class CreateAttentions < ActiveRecord::Migration[6.1]
  def change
    create_table :attentions do |t|
      t.integer :customer_id
      t.integer :forum_id

      t.timestamps
    end
  end
end
