class Admin::HomesController < ApplicationController

  def top
    # report（通報)があったrecipe(投稿)だけを降順で並べる
    if params[:order] == 'desc'
      @recipes = Recipe.joins(:reports).group(:recipe_id).order('count(recipe_id) desc').page(params[:page])
    # すべての投稿を降順に表示
    else
      @recipes = Recipe.order(created_at: :desc).page(params[:page])
    end
  end

end
