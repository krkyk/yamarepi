class Public::ForumCommentsController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    @forum_comment = current_customer.forum_comments.new(forum_comment_params)
    @forum_comment.forum_id = @forum.id
    @forum_comment.save
    @forum_comments = @forum.forum_comments.order(created_at: 'DESC').page(params[:page]).per(5)
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
end
