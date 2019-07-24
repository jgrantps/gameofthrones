class GameOfThrones::Categories
  attr_accessor :name, :url, :index

@@all = []
   def initialize(name, url, index)
     @url = url
     @name = name
     @index = index
     @@all<<self

    # subcategory_scraper
    #  subcategory_list
   end

   def self.all
     @@all
   end

   def subcategory_scraper
     @toilet_url = []
     subpage = Nokogiri::HTML(open(@url))
     subproducts = subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")
     @toilet_url = subproducts.collect {|t| "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?")}
     @toilet_names = subproducts.collect {|t| t.css("p.product-panel__summary.product-panel__summary-new").text}
     @toilet_prices = subproducts.collect {|t| t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip}

    #  binding.pry
    guess
   end

   def toilet_url
     @toilet_url
   end

   def toilet_names
     @toilet_names
   end

   def toilet_price
     @toilet_prices
   end

   def name_price_hash #=> returns hash in the form of [name => price]
     hash = {}
     toilet_names.zip(toilet_price).map do |i|
       hash[i[0]] = i[1]
     end
     binding.pry
   end

   def index_url_hash #=> returns hash in the form of [index => URL]
     hash = {}
     count = 1
     toilet_names.zip(toilet_url).map do |i|
       hash[count] = i[1]
       count +=1
     end
    # binding.pry
     hash
   end

   def title_url_hash #=> returns hash in the form of [title => URL]
     hash = {}
     toilet_names.zip(toilet_url).map do |i|
       hash[i[0]] = i[1]
     end
    #  binding.pry
     hash
   end

   def index_title_hash #=> returns hash in the form of [index => title]
     hash = {}
     count = 1
     toilet_url.zip(toilet_names).map do |i|
       hash[count] = i[1]
       count +=1
     end
    #  binding.pry
     hash
   end

   def guess
     puts "\nTo guess which throne you think is the most expensive, enter the # followed by a '?'\n\n"
     puts "To find out more info on each throne, enter the # followed by a '!'\n\n"
    guess_display
    input = gets.strip
    guess_check(input)
    end

   def guess_display #=> returns the list of toilets to choose from.
     index_title_hash.each do |key, value|
       puts "#{key}. #{value}."
     end
  end

  def guess_check(var) #=> checks the input/var against the list and returns correct/incorrect.
    #if var == #the top price in the name_price_hash
      if var.split("").last == "!"
        GameOfThrones::SubCategories.new(url)
        puts "you entered in #{var} with an exclamation point"
      elsif var.split("").last == "?"
        puts "you entered in #{var} with a question mark"
      else
        puts "you entered a typ - try again!"
      guess
      end
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
