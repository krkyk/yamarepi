class Inquiry < ApplicationRecord

  with_options presence: true do
    validates :inquiry_name
    validates :message
    validates :email
  end

  enum subject:{やまレピの機能やご利用方法について:0,タグの削除や追加について:1,上記以外のお問合せ:2}

end
