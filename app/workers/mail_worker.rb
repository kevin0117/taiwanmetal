class MailWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  sidekiq_options queue: :default, retry: 3

  def perform(user_id)
    user = User.find(user_id)
    if user
      CommodityMailer.deal_closed_email(user).deliver_later
    else
      errors.add(:base, '找不到使用者')
      throw(:abort)
    end
  end
  
end
