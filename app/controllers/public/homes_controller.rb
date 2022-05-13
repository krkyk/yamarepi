class Public::HomesController < ApplicationController

  def top
    @recipes = Recipe.page(params[:page]).per(3).order(created_at: :desc)
  end

end
