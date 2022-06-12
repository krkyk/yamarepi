class Public::ForumReportsController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    forum_report = current_customer.forum_reports.new(forum_id: @forum.id)
    forum_report.save
  end

  def destroy
    @forum = Forum.find(params[:forum_id])
    forum_report = current_customer.forum_reports.find_by(forum_id: @forum.id)
    forum_report.destroy
  end
end
