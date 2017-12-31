class UserMailer < ApplicationMailer
  default template_path: 'mailers/user_mailer'
  default from: Settings.mail.from

  def remind_confirmation(user)
    @user = user
    mail(to: user.email, subject: '【リマインドメール】nominiリニューアルのお知らせ。メール記載のURLよりマイページへのログインをお願い致します')
  end
end
