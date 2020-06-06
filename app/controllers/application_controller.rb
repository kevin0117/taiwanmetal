class ApplicationController < ActionController::Base
  def generate_barcode(text, id)
      barcode = Barby::Code39.new(text, true)
      outputter = Barby::PngOutputter.new(barcode)
      File.open("#{Rails.root}/public/barcode-#{id}.png", 'wb'){|f| f.write outputter.to_png }
  end
end
