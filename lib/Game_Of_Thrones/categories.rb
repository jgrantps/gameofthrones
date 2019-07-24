class GameOfThrones::Categories
  @@subpage = ""
  @@subcategories = ""

   def initialize(url = "")
     puts "hello from subcategories!!"
     @url = url
     subcategory_scraper
   end

   def subcategory_scraper
     @@subpage = Nokogiri::HTML(open(@url))
     @@subcategories = @@subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")
     binding.pry
   end

   def self.subpage
     @@subpage
   end

   def self.subcategories
     @@subcategories
   end




end
