# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecipeTagモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(RecipeTag.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(RecipeTag.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end
