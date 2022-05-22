class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: "system@example.com",
      to:   ENV['SMTP_USERNAME'],
      subject: "やまレピ/お問い合わせ通知"
    )
  end
end
