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
     puts "\n-->  Guess which throne you think is the most expensive by entering the corresponding index number."
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
    a = @displayed_toilets.map {|i| i.index.to_s }.include? var.split(/[?]/).first
    b = @displayed_toilets.map {|i| i.index.to_s.split("").last }.include? var.split("").last
    c = (var.split("").last == "?")
      if a && (b || c)
        puts "Your input is valid!"
         if var.split("").last == "?"
           info_lookup(var) #=> returns name, price, and url for the toilet.
         else
           game_check(var) #=> compares the input 'var' against the @displayed_toilets to see if it was the most expensive.
         end
      else #=> returns error message and prompts user to retry.
        puts "you entered a typo - try again!"
        input_check
      end
  end

  def info_lookup(input)
    selected_index = input.gsub("?","").to_i
  throne =   @displayed_toilets.detect { |toilet| toilet.index == selected_index}

  puts "Name: #{throne.name}"
  puts "Category: #{throne.category.name}"
  puts "Price: #{throne.price}"
  puts "Website: #{throne.url}"

  binding.pry

    toilet.index
  end


end
