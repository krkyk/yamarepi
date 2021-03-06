class Public::ForumCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_customer, only: [:destroy]

  def create
    @forum = Forum.find(params[:forum_id])
    @forum_comment = current_customer.forum_comments.new(forum_comment_params)
    @forum_comment.forum_id = @forum.id
    @forum_comments = @forum.forum_comments.order(created_at: 'DESC').page(params[:page]).per(5)
    unless @forum_comment.save
      render 'error'
    end
  end

  def destroy
    @forum = Forum.find(params[:forum_id])
    ForumComment.find(params[:id]).destroy
    @forum_comments = @forum.forum_comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end

  private

  def forum_comment_params
    params.require(:forum_comment).permit(:forum_comment)
  end

  def ensure_customer
    @forum_comment = ForumComment.find(params[:id])
    unless @forum_comment.customer == current_customer
      redirect_to root_path, notice: 'その機能は使用できません。'
    end
  end
end
