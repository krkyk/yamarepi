Admin.create!(
  email: 'admin@admin.com',
  password: 'yamarepi'
)

Tag.create!([
              { name: '簡単' },
              { name: '初心者におすすめ' },
              { name: '携帯食' },
              { name: 'クッカー' },
              { name: 'メスティン' },
              { name: 'ホットサンドメーカー' },
              { name: 'キャンプ' }
            ])

Customer.create!([
                   { name: 'まさみ', email: 'sample1@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') },
                   { name: 'メイ', email: 'sample2@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') },
                   { name: 'ゆい', email: 'sample3@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') },
                   { name: 'Mitsuki', email: 'sample4@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') },
                   { name: 'はるか', email: 'sample5@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') },
                   { name: 'けんと', email: 'sample6@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') },
                   { name: 'マサキ', email: 'sample7@sample.com', password: 'password', is_deleted: false,
                     customer_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename: 'sample-customer1.jpg') }
                 ])

Recipe.create!([
                 { customer_id: 1, title: 'hoge', serving: 1, description: 'hoge', recipe_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                 { customer_id: 2, title: 'hoge', serving: 2, description: 'hoge', recipe_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe2.jpg"), filename: 'sample-recipe2.jpg') }
               ])

Ingredient.create!([
                     { recipe_id: 1, content: 'hoge', quantity: 'hoge' },
                     { recipe_id: 2, content: 'hoge', quantity: 'hoge' }
                   ])

Step.create!([
               { recipe_id: 1, step_description: 'hoge' },
               { recipe_id: 2, step_description: 'hoge' }
             ])

Comment.create!([
                  { customer_id: 2, recipe_id: 1, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                  { customer_id: 3, recipe_id: 1, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                  { customer_id: 4, recipe_id: 1, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                  { customer_id: 5, recipe_id: 1, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                  { customer_id: 6, recipe_id: 1, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                  { customer_id: 7, recipe_id: 1, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe1.jpg"), filename: 'sample-recipe1.jpg') },
                  { customer_id: 3, recipe_id: 2, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe2.jpg"), filename: 'sample-recipe2.jpg') },
                  { customer_id: 4, recipe_id: 2, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe2.jpg"), filename: 'sample-recipe2.jpg') },
                  { customer_id: 5, recipe_id: 2, comment: '美味しくできました！',
                    comment_image: ActiveStrage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-recipe2.jpg"), filename: 'sample-recipe2.jpg') }
                ])

Favorite.create!([
                   { customer_id: 3, recipe_id: 1 },
                   { customer_id: 4, recipe_id: 1 },
                   { customer_id: 5, recipe_id: 1 },
                   { customer_id: 3, recipe_id: 2 },
                   { customer_id: 6, recipe_id: 2 },
                   { customer_id: 1, recipe_id: 2 }
                 ])

Report.create!([
                 { customer_id: 4, recipe_id: 1 },
                 { customer_id: 6, recipe_id: 1 }
               ])
