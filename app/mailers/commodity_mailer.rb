class CommodityMailer < ApplicationMailer
  default from: 'postmaster@chienhao.tw'

  def deal_closed_email(user_object)
    @user = user_object
    
    @url = 'https://taiwanmetal.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: "委託單成交")
  end

  def notify_deal_email(admin, starter, closer)
    @admin = admin
    @starter = starter
    @closer = closer

    @url = 'https://taiwanmetal.herokuapp.com/users/sign_in'

    mail(to: @admin.email, subject: "委託單成交")
  end
end
 