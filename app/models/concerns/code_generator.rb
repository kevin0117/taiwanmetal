module CodeGenerator
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :code_generator, use: :slugged, slug_column: :code
  end

  private

  def code_generator
    return SecureRandom.hex(1) + "P" + self.cost.to_i.to_s.reverse + "P" + SecureRandom.hex(1) if self.kind_of?(Product)
    SecureRandom.hex(5)
  end
end