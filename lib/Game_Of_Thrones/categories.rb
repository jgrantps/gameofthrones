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
    if self.toilets == []

      subproducts.each do |t|
        GameOfThrones::Thrones.new(t.css("p.product-panel__summary.product-panel__summary-new").text, t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip, "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?"), count, self)
        count += 1
      end
    end
      # binding.pry
   end

   def guess #=> Prompts user for selection
     puts "\n-->  Guess which throne you think is the most expensive by entering the corresponding index number."
     puts "--> To find out more info on each throne, enter the index number followed by a '?'\n\n"
    selection_generator #=> displays toilet table for user to make an decision over.
    # input = gets.strip
    input_check #=> returns response based on if there is request for more details, a guess is made, or input is an error.
  end

   def selection_generator #=> returns the list of 3 random toilets to choose from.

     self.toilets.sample(3).each do |toilet|
       puts "   #{toilet.index}. #{toilet.name}"
       @displayed_toilets << toilet #=> stores the generated selection in a dedicated array.
     end
# binding.pry
  end

  def input_check #=> routes the program to the appropriate method based on the var argument.
    input = gets.strip
    throne =   @displayed_toilets.detect { |toilet| toilet.index == (input.gsub("?","").to_i)}




    a = @displayed_toilets.map {|i| i.index.to_s }.include? input.split(/[?]/).first
    b = @displayed_toilets.map {|i| i.index.to_s.split("").last }.include? input.split("").last
    c = (input.split("").last == "?")
      if a && (b || c)
         if input.split("").last == "?"
           info_lookup(throne) #=> returns name, price, and url for the toilet.
         else
           game_check(throne) #=> compares the input 'var' against the @displayed_toilets to see if it was the most expensive.
         end
      else #=> returns error message and prompts user to retry.
        puts "you entered a typo - try again!"
        input_check
      end
  end

  def info_lookup(throne)
    # selected_index = input.gsub("?","").to_i
    # throne =   @displayed_toilets.detect { |toilet| toilet.index == selected_index}

    puts "\nCategory: #{throne.category.name}"
    puts "Name: #{throne.name}"
    puts "Price: #{throne.price}"
    puts "Website: #{throne.url}\n\n"

    input_check
  end

  def game_check(throne)
    sorted = @displayed_toilets.map { |t|  t.price_i }.sort {|a,b| b <=> a }
# binding.pry
    if throne.price_i == sorted.first
      puts "\nCongratulations!  You answered correctly."
      play_again
    else
      puts "Wrong!  Try again."
      input_check
    # binding.pry
    end
  end


  def play_again
    puts "Would you like to play again? y/n"
    choice = gets.strip
    if choice == "n"
      puts "Thanks for playing and have a great day!"
    elsif choice == "y"
      # binding.pry
      @displayed_toilets = []
      GameOfThrones::Controller.new.make_selection
    else
      # binding.pry
      puts "please type in 'y' or 'n' to make your selection."
      play_again
    end
  end


end
