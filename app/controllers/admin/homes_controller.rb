class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
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
end
