class QrCode
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def self.call(url)
    new(url).call
  end

  def call
    qrcode = RQRCode::QRCode.new(url)
    qrcode.as_svg(
      offset: 0,
      color: '000000',
      module_size: 4,
      standalone: true
    ).html_safe
  end
end


# class QrCode
#   def self.call(url_path)
#     qrcode = RQRCode::QRCode.new(url_path)
#     qrcode.as_svg(
#       offset: 0,
#       color: '000000',
#       module_size: 3,
#       standalone: true
#     ).html_safe
#   end
# end
