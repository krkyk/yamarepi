class CreateForums < ActiveRecord::Migration[6.1]
  def change
    create_table :forums do |t|
      t.integer :customer_id
      t.string :forum_title
      t.string :forum_content

      t.timestamps
    end
  end
end
