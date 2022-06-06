class Public::AttentionsController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    attention = current_customer.attentions.new(forum_id: @forum.id)
    attention.save
  end

  def destroy
    @forum = Forum.find(params[:forum_id])
    attention = current_customer.attentions.find_by(forum_id: @forum.id)
    attention.destroy
  end
end
