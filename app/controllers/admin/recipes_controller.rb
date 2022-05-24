class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def index
    # レシピを新着順に並べる
    if params[:latest]
      @recipes = Recipe.latest.page(params[:page])
    # レシピを通報が多い順に並べる
    elsif params[:report]
      @recipes = Kaminari.paginate_array(Recipe.recipe_reports).page(params[:page])
    else
      @recipes = Recipe.page(params[:page])
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
  end

  def destroy
    recipe = Recipe.find(params[:id])
    if recipe.destroy
      redirect_to admin_recipes_path, notice: "投稿を削除しました。"
    end
  end

  private

  def post_params
    params.require(:recipe).permit(:report)
  end

end
