class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
    @comment = current_customer.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.save
    # コメントを投稿すると非同期でコメント最終ページを表示
    last_page = @recipe.comments.page(1).per(5).total_pages
    @comments = @recipe.comments.page(last_page).per(5)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
    Comment.find(params[:id]).destroy
    last_page = @recipe.comments.page(1).per(5).total_pages
    @comments = @recipe.comments.page(last_page).per(5)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:comment_image)
  end

end
