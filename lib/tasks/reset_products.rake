namespace :db do
  desc '重設商品：加入進貨單'
  task :reset_products => :environment do
    puts "resetting products..."
    Product.all.each do |product|
      product.update(purchase_order_id: 1)
    end
    puts "done"
  end
end