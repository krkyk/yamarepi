class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

end
