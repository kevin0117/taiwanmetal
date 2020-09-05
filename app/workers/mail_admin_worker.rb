class MailAdminWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  sidekiq_options queue: :default, retry: 3

  def perform(user_id, starter_id, closer_id)
    admin = User.find(user_id)
    starter = User.find(starter_id)
    closer = User.find(closer_id)
    if admin && starter && closer
      CommodityMailer.notify_deal_email(admin, starter, closer).deliver_later
    else
      errors.add(:base, '找不到使用者')
      throw(:abort)
    end
  end
end
