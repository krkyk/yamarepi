class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def index
    # レシピを新着順に並べる
    @recipes = if params[:latest]
                 Recipe.latest.page(params[:page])
               # レシピを通報が多い順に並べる
               elsif params[:report]
                 Kaminari.paginate_array(Recipe.recipe_reports).page(params[:page])
               else
                 Recipe.page(params[:page])
               end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @steps = @recipe.steps
    @comments = @recipe.comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    redirect_to admin_recipes_path, notice: '投稿を削除しました。' if recipe.destroy
  end

  private

  def post_params
    params.require(:recipe).permit(:report)
  end
end
