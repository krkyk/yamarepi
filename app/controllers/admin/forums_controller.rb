class Admin::ForumsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @forums = if params[:latest]
                # トピックを新着順に並べる
                Forum.order(created_at: 'DESC').page(params[:page])
              elsif params[:forum_report]
                # トピックを通報が多い順に並べる
                Kaminari.paginate_array(Forum.forum_reports).page(params[:page])
              else
                Forum.page(params[:page])
              end
  end

  def show
    @forum = Forum.find(params[:id])
    @forum_comments = @forum.forum_comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end

  def destroy
    forum = Forum.find(params[:id])
    redirect_to admin_forums_path, notice: 'トピックを削除しました。' if forum.destroy
  end

  private

  def post_params
    params.require(:forum).permit(:forum_report)
  end
end
