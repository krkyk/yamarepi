# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:customer) { FactoryBot.build(:customer) }
    subject { customer.valid? }
    context 'nameカラム' do
      let(:test_customer) { customer }
      it '空欄でないこと' do
        test_customer.name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_customer.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_customer.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:recipes).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'Reportモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:reports).macro).to eq :has_many
      end
    end
  end
end