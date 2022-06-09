class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    @steps = @recipe.steps
    @comment = current_customer.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comments = @recipe.comments.order(created_at: 'DESC').page(params[:page]).per(5)
    unless @comment.save
      render 'error'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    @steps = @recipe.steps
    Comment.find(params[:id]).destroy
    @comments = @recipe.comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :comment_image)
  end
end
