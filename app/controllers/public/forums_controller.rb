class Public::ForumsController < ApplicationController
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
    @forums = Forum.page(params[:page])
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
      redirect_to forum_path(@forum.id), notice: '投稿を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    @form.destroy
    redirect_to forums_path, notice: '投稿を削除しました。'
  end

  private

  def forum_params
    params.require(:forum).permit(:forum_title, :forum_content)
  end
end
