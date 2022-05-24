# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:comment) { FactoryBot.build(:comment) }
    subject { comment.valid? }
    let(:customer) { create(:customer) }
    let!(:comment) { build(:comment, customer_id: customer.id) }
    context 'commentカラム' do
      it '空欄でないこと' do
        comment.comment = ''
        is_expected.to eq false;
      end
      it '30文字以下であること' do
        comment.comment = Faker::Lorem.characters(number:31)
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end