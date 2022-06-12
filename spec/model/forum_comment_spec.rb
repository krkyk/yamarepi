# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ForumCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:forum_comment) { FactoryBot.build(:forum_comment) }
    subject { forum_comment.valid? }
    let(:customer) { create(:customer) }
    let!(:forum_comment) { build(:forum_comment, customer_id: customer.id) }
    context 'forum_commentカラム' do
      it '空欄でないこと' do
        forum_comment.forum_comment = ''
        is_expected.to eq false
      end
      it '100文字以下であること' do
        forum_comment.forum_comment = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Forumモデルとの関係' do
      it 'N:1となっている' do
        expect(ForumComment.reflect_on_association(:forum).macro).to eq :belongs_to
      end
    end
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(ForumComment.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
