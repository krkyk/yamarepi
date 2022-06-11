# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forumモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:forum) { FactoryBot.build(:forum) }
    subject { forum.valid? }
    let(:customer) { create(:customer) }
    let!(:forum) { build(:forum, customer_id: customer.id) }
    context 'forum_titleカラム' do
      it '空欄でないこと' do
        forum.forum_title = ''
        is_expected.to eq false
      end
      it '30文字以下であること' do
        forum.forum_title = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end
    context 'forum_contentカラム' do
      it '空欄でないこと' do
        forum.forum_content = ''
        is_expected.to eq false
      end
      it '200文字以下であること' do
        forum.forum_content = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Forum.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'ForumCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Forum.reflect_on_association(:forum_comments).macro).to eq :has_many
      end
    end
    context 'ForumReportモデルとの関係' do
      it '1:Nとなっている' do
        expect(Forum.reflect_on_association(:forum_reports).macro).to eq :has_many
      end
    end
    context 'Attentionモデルとの関係' do
      it '1:Nとなっている' do
        expect(Forum.reflect_on_association(:attentions).macro).to eq :has_many
      end
    end
  end
end
