class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @recipes = if params[:latest]
                # レシピを新着順に並べる
                 Recipe.latest.page(params[:page])
               elsif params[:report]
                # レシピを通報が多い順に並べる
                 Kaminari.paginate_array(Recipe.recipe_reports).page(params[:page])
               else
                 Recipe.page(params[:page])
               end
  end
end
