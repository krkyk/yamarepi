# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:recipe) { FactoryBot.build(:recipe) }
    subject { recipe.valid? }
    let(:customer) { create(:customer) }
    let!(:recipe) { build(:recipe, customer_id: customer.id) }
    context 'titleカラム' do
      it '空欄でないこと' do
        recipe.title = ''
        is_expected.to eq false
      end
      it '15文字以下であること' do
        recipe.title = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'Ingredientモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:ingredients).macro).to eq :has_many
      end
    end
    context 'Stepモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:steps).macro).to eq :has_many
      end
    end
    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
    context 'RecipeTagモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:recipe_tags).macro).to eq :has_many
      end
    end
    context 'Favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Reportモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:reports).macro).to eq :has_many
      end
    end
  end
end
