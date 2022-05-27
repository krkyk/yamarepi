class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.latest.page(params[:page]).per(6)
  end
end
