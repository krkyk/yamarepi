class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    @steps = @recipe.steps
    Comment.find(params[:id]).destroy
    @comments = @recipe.comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end
end
