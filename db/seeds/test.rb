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
              { name: 'キャンプ' },
              { name: '麺類' }
            ])