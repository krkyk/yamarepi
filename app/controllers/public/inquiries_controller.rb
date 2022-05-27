class Public::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  # 入力値のチェックページ
  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    render 'new' if @inquiry.invalid?
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver
      redirect_to root_path, notice: 'お問い合わせを送信しました。'
    else
      params[:back] || !@inquiry.save
      render 'new'
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:inquiry_name, :message, :email, :subject)
  end
end
