# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ForumReportモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Forumモデルとの関係' do
      it 'N:1となっている' do
        expect(ForumReport.reflect_on_association(:forum).macro).to eq :belongs_to
      end
    end
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(ForumReport.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
