# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reportモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(Report.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Report.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
