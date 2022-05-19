class Public::InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new
  end

  # 入力値のチェックページ
  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render "confirm"
    else
      render "new"
    end
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver
      redirect_to done_path
    else
      render "new"
    end
  end

  def done
  end

  private

  def inquiry_params
    params.require(:inqury).permit(:inquiry_name,:message,:email,:subject)
  end

end
