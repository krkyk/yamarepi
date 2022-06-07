class Public::ForumsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)
    @forum.customer_id = current_customer.id
    if @forum.save
      redirect_to forum_path(@forum.id), notice: '掲示板に投稿しました。'
    else
      render 'new'
    end
  end

  def index
    @forums = if params[:latest]
                # トピックを新着順に並べる
                Forum.order(created_at: 'DESC').page(params[:page])
              elsif params[:attention]
                # トピックを注目が多い順に並べる
                Kaminari.paginate_array(Forum.forum_attentions).page(params[:page])
              elsif params[:week_attention]
                # トピックを１週間で注目が多い順に並べる
                Kaminari.paginate_array(Forum.forum_week_attentions).page(params[:page])
              else
                Forum.page(params[:page])
              end
  end

  def show
    @forum = Forum.find(params[:id])
    @forum_comment = ForumComment.new
    @forum_comments = @forum.forum_comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update(forum_params)
      redirect_to forum_path(@forum.id), notice: 'トピックを更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    @form.destroy
    redirect_to forums_path, notice: 'トピックを削除しました。'
  end

  private

  def forum_params
    params.require(:forum).permit(:forum_title, :forum_content)
  end
end
