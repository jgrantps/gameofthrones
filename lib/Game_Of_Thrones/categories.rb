class GameOfThrones::Categories
  attr_accessor :name, :url

  @subpage = ""
  @subcategories = ""

   def initialize(url = "", name = "")
     puts "hello from subcategories!!"
     @url = url
     @name = name
     subcategory_scraper
     puts "the name of this object is #{@name}"
     puts "Choose from the following Toilets:"
     subcategory_list
   end

   def subcategory_scraper
     @subpage = Nokogiri::HTML(open(@url))
     @subcategories = @subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")
    #  binding.pry
   end

   def subpage
     @subpage
   end

   def subcategories
     @subcategories
   end

   def subcategory_list

   end





end
