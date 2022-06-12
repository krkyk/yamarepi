class CreateForumComments < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_comments do |t|
      t.integer :customer_id
      t.integer :forum_id
      t.string :forum_comment

      t.timestamps
    end
  end
end
