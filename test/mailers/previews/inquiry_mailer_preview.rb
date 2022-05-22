# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def inquiry
     inquiry = Inquiry.new(inquiry_name: "お名前", message: "お問い合わせメッセージ", email: "sample@sample.com")

     InquiryMailer.send_mail(inquiry)
   end

end
