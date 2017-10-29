class IntroductionMailer < ApplicationMailer
  default template_path: 'mailers/introduction_mailer'
  default from: Settings.mail.from

  def introduction_mail(introduction)
    @introduction = introduction
    mail(to: @introduction.introduced_email, subject: 'nominiへの招待メールが届きました。')
  end
end
