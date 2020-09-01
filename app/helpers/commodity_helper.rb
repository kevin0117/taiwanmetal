module CommodityHelper
  def print_action(action)
    if action == "Buy"
      "買進"
    else
      "賣出"
    end
  end
end