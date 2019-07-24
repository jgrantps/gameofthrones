class GameOfThrones::Categories
  attr_accessor :name, :url


   def initialize(url = "", name = "")
     puts "hello from subcategories!!"
     @subpage = ""
     @subcategories = ""
     @subhash = {}
     @url = url
     @name = name

     subcategory_scraper
     puts "the name of this object is #{@name}"
     puts "Choose from the following Toilets:"
     subcategory_scraper
    #  subcategory_list
   end

   def subcategory_scraper
     @toilet_url = []
     subpage = Nokogiri::HTML(open(@url))
     subproducts = subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")
     @toilet_url = subproducts.collect {|t| "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?")}
     @toilet_names = subproducts.collect {|t| t.css("p.product-panel__summary.product-panel__summary-new").text}
     @toilet_prices = subproducts.collect {|t| t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip}
    #  binding.pry
   end

   def subpage
     @subpage
   end

   def subcategories
     @subcategories
   end

   def subcategory_list
     @subhash = {}
   end





end
