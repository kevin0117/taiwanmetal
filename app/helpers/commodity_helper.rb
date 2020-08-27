module CommodityHelper
  def print_action(action)
    if action == "Buy"
      "求買"
    else
      "求賣"
    end
  end
end