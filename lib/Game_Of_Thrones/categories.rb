class GameOfThrones::Categories
  attr_accessor :name, :url, :index, :toilets

@@all = []
   def initialize(name, url, index)
     @url = url
     @name = name
     @index = index
     @toilets = []
     @displayed_index = []
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

   def guess #=> Prompts user for selection
     puts "\n--> To guess which throne you think is the most expensive, enter the # followed by a '!'"
     puts "--> To find out more info on each throne, enter the # followed by a '?'\n\n"
    guess_display #=> displays toilet table for user to make an decision over.
    input = gets.strip
    input_check(input) #=> returns response based on if there is request for more details, a guess is made, or input is an error.
  end

   def guess_display #=> returns the list of 3 random toilets to choose from.

     self.toilets.sample(3).each do |toilet|
       puts "   #{toilet.index}. #{toilet.name}, #{toilet.price}"
       @displayed_index << toilet.index.to_s
     end
binding.pry
  end

  def input_check(var) #=> routes the program to the appropriate method based on the var argument.
    #if var == #the top price in the name_price_hash
      if @displayed_index.include? var.split("").first #=> checks if the input number is a match for any toilet index in the guess_display.
        puts "Your input is valid!"
       if var.split("").last == "!"
      #   GameOfThrones::SubCategories.new(url)
      #   puts "you entered in #{var} with an exclamation point"
      # elsif var.split("").last == "?"
      #   puts "you entered in #{var} with a question mark"
      else
        puts "you entered a typo - try again!"
      guess
      end
  end

end
