class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
    Comment.find(params[:id]).destroy
  end

end
