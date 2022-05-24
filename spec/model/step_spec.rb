# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stepモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:step) { FactoryBot.build(:step) }
    subject { step.valid? }
    let(:recipe) { create(:recipe) }
    let!(:step) { build(:step, recipe_id: recipe.id) }
    context 'step_descriptionカラム' do
      it '空欄でないこと' do
        step.step_description = ''
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(Step.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
  end
end