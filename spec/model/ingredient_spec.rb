# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ingredientモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:ingredient) { FactoryBot.build(:ingredient) }
    subject { ingredient.valid? }
    let(:recipe) { create(:recipe) }
    let!(:ingredient) { build(:ingredient, recipe_id: recipe.id) }
    context 'contentカラム' do
      it '空欄でないこと' do
        ingredient.content = ''
        is_expected.to eq false;
      end
    end
    context 'quantityカラム' do
      it '空欄でないこと' do
        ingredient.quantity = ''
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(Ingredient.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
  end
end