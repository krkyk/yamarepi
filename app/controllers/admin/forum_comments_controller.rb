class Admin::ForumCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @forum = Forum.find(params[:forum_id])
    ForumComment.find(params[:id]).destroy
    @forum_comments = @forum.forum_comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end
end
