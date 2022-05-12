class Admin::RecipesController < ApplicationController

  def index
    # report（通報)があったrecipe(投稿)だけを降順で並べる
    if params[:order] == 'desc'
      @recipes = Recipe.joins(:reports).group(:recipe_id).order('count(recipe_id) desc').page(params[:page])
    # すべての投稿を降順に表示
    else
      @recipes = Recipe.order(created_at: :desc).page(params[:page])
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
      redirect_to admin_recipes_path, notice: "投稿を削除しました"
    end
  end

  private

  def post_params
    #通報数を編集するからいる？
    params.require(:recipe).permit(:report)
  end

end
