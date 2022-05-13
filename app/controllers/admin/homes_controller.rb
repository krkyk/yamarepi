class Admin::HomesController < ApplicationController

  def top
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

end
