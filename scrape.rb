require 'mysql2'
require "./lib/scraper.rb"


client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '11111111')
client.select_db( 'eastwind' )
categories = client.query("SELECT * from categories")
#puts categories.size
categories.each do |category|
 #puts category['url'] 
  scrape = Scraper.new( "#{category['url']}" ) 
  scrape.get_ids.each do |product|
  product_id =  product['href'].split(".")[0]
  if product_id.include?('wholesale')
    next
  end  
  puts product_id 
  client.query( "INSERT INTO products_categories ( product_id, category_id )
           VALUES
            ('#{ product['href'].split(".")[0] }','#{category['id'] }' )" ) 
    
  end 

end
