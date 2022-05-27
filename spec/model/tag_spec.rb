# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:tag) { FactoryBot.build(:tag) }
    subject { tag.valid? }
    context 'nameカラム' do
      it '空欄でないこと' do
        tag.name = ''
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:recipes).macro).to eq :has_many
      end
    end
    context 'RecipeTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:recipe_tags).macro).to eq :has_many
      end
    end
  end
end
