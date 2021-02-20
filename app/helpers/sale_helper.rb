module SaleHelper
  def find_product_quantity(product)
    @sale.manifests.find_by(product_id: product.id).quantity
  end

  def find_product_weight(product)
    @sale.manifests.find_by(product_id: product.id).weight
  end
end
