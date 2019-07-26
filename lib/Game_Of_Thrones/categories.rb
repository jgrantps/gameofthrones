class GameOfThrones::Categories
  attr_accessor :name, :url, :index, :toilets

@@all = []
   def initialize(name, url, index)
     @url = url
     @name = name
     @index = index
     @toilets = []
     @@all<<self
   end

   def self.all
     @@all
   end

   def thrones_scraper
#=> scrape the category for its corresponding toilets.
     subpage = Nokogiri::HTML(open(@url))
     subproducts = subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")
      count = 1
#=> instantiates individual toilets that belong to the category.
      subproducts.each do |t|
        GameOfThrones::Thrones.new(t.css("p.product-panel__summary.product-panel__summary-new").text, t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip, "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?"), count, self)
        count += 1
      end
   end

   def guess
     puts "\nTo guess which throne you think is the most expensive, enter the # followed by a '?'\n\n"
     puts "To find out more info on each throne, enter the # followed by a '!'\n\n"
    guess_display
    binding.pry
    input = gets.strip
    # guess_check(input)
  end

   def guess_display #=> returns the list of toilets to choose from.
     self.toilets.sample(3).each do |toilet|
       puts "#{toilet.index}. #{toilet.name}, #{toilet.price}"
     end
    #  binding.pry
  end

  # def guess_check(var) #=> checks the input/var against the list and returns correct/incorrect.
  #   #if var == #the top price in the name_price_hash
  #     if var.split("").last == "!"
  #       GameOfThrones::SubCategories.new(url)
  #       puts "you entered in #{var} with an exclamation point"
  #     elsif var.split("").last == "?"
  #       puts "you entered in #{var} with a question mark"
  #     else
  #       puts "you entered a typ - try again!"
  #     guess
  #     end
  # end

end
