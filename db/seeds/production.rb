Admin.create!(
  email: 'admin@admin.com',
  password: 'yamarepi'
)

Tag.create!([
              { name: '簡単' },
              { name: '初心者におすすめ' },
              { name: 'クッカー' },
              { name: 'メスティン' },
              { name: 'ホットサンドメーカー' },
              { name: '携帯食' },
              { name: 'キャンプ' }
            ])
