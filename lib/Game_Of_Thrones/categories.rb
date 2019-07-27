class GameOfThrones::Categories
  attr_accessor :name, :url, :index, :toilets

@@all = []
   def initialize(name, url, index)
     @url = url
     @name = name
     @index = index
     @toilets = []
     @displayed_toilets = []
     @@all<<self
   end

   def self.all
     @@all
   end

   def thrones_scraper
#=> scrapes the category for its corresponding toilets.
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
    selection_generator #=> displays toilet table for user to make an decision over.
    # input = gets.strip
    input_check #=> returns response based on if there is request for more details, a guess is made, or input is an error.
  end

   def selection_generator #=> returns the list of 3 random toilets to choose from.

     self.toilets.sample(3).each do |toilet|
       puts "   #{toilet.index}. #{toilet.name}, #{toilet.price}"
       @displayed_toilets << toilet #=> stores the generated selection in a dedicated array.
     end
# binding.pry
  end

  def input_check #=> routes the program to the appropriate method based on the var argument.
    var = gets.strip

    a = @displayed_toilets.map {|i| i.index.to_s }.include? var.split("").first
    b = (var.split("").last == "!")
    c = (var.split("").last == "?")

      # if (@displayed_toilets.map {|i| i.index.to_s }.include? var.split("").first && ((var.split("").last == "!") || (var.split("").last == "?")) == true)#=> checks if the input number is a match for any toilet index in the guess_display.
      if a && (b || c) == true
        # binding.pry

        puts "Your input is valid!"
      #  if var.split("").last == "!" #=> returns responese for if the user makes a guess.
      #    #=> returns the toilet.index, name, and price for the toilet seleted.
      #  if var.split("").last == "?" #=> returns response ofr if the user asks for more information.
      #    #=> checks to see whether the toilet selected in the input is the most expensive.
      else #=> returns error message and prompts user to retry.
        # binding.pry
        puts "you entered a typo - try again!"
        input_check
      end
  end
end
