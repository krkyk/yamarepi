class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :inquiry_name, null: false
      t.string :message, null: false
      t.string :email, null: false
      t.integer :subject, default: 0,null: false

      t.timestamps
    end
  end
end
