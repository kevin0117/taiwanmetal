class AdminMailer < Devise::Mailer
  default from: 'postmaster@chienhao.tw'
  layout 'mailer'

  def new_user_waiting_for_approval(email)
    @email = email
    mail(to: 'kevin0117@gmail.com', subject: 'New User Awaiting Admin Approval')
  end
end