class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
    @comment = current_customer.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:comment_image)
  end

end
