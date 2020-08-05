namespace :scrap do
  desc '產生 10 筆樣本商品'
  task :generate => :environment do
    puts "generating scraps..."
    10.times { FactoryBot.create(:scrap, user_id: 3) }
    puts "done"
  end
end