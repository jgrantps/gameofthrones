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
   end

   def guess #=> Prompts user for selection
     puts "\nGuess which throne you think is the most expensive by entering the corresponding index number."
     puts "To find out more info on each throne, enter the index number followed by a '?'\n\n"
    selection_generator #=> displays toilet table for user to make an decision over.
    input_check #=> returns response based on if there is request for more details, a guess is made, or input is an error.
  end

   def selection_generator #=> returns the list of 3 random toilets to choose from.

     self.toilets.sample(3).each do |toilet|
       puts "   #{toilet.index}. #{toilet.name}"
       @displayed_toilets << toilet #=> stores the generated selection in a dedicated array.
     end
  end

  def input_check #=> routes the program to the appropriate method based on the var argument.
    input = gets.strip
    throne =   @displayed_toilets.detect { |toilet| toilet.index == (input.gsub("?","").to_i)} #=> matches the toilet in the @displayed_toilets array to the user input.
    a = @displayed_toilets.map {|i| i.index.to_s }.include? input.split(/[?]/).first #=> checks to confirm that the user input keystrokes preceeding a possible "?" keystroke matches any of the @displayed_toilets index numbers.
    b = @displayed_toilets.map {|i| i.index.to_s.split("").last }.include? input.split("").last #=> checks if provided user input doesn't contains the "?" as the last keystroke, implying a guess is made.
    c = (input.split("").last == "?") #=> checks if provided user input contains the "?" as the last keystroke, implying a request for more information.
      if a && (b || c) # => equates to "if the user input number matches exactly any of the @displayed_toilets indexes, AND the user input either only ends with a question mark OR ends without a question mark"
         if input.split("").last == "?"
           info_lookup(throne) #=> returns name, price, and url for the toilet.
         else
           game_check(throne) #=> compares the input 'var' against the @displayed_toilets to see if it was the most expensive.
         end
       elsif input == "exit"
         puts "Thanks for playing!"
      else #=> returns error message and prompts user to retry.
        puts "you entered a typo - try again!"
        input_check
      end
  end

  def info_lookup(throne) #=> displays scraped information about the selected toilet.
    puts "\nCategory: #{throne.category.name}"
    puts "Name: #{throne.name}"
    puts "Price: #{throne.price}"
    puts "Website: #{throne.url}\n\n"
    input_check
  end

  def game_check(throne) #=> checks to see if the user input was correct, incorrect.
    sorted = @displayed_toilets.map { |t|  t.price_i }.sort {|a,b| b <=> a } #=> returns an array of the integer prices sorted from highest to lowest.
    if throne.price_i == sorted.first #=> checks to see if the users selected toilet price matches the first item in the sorted array.
      puts "\nCongratulations!  You answered correctly."
      play_again
    else
      puts "Wrong!  Try again."
      input_check
    end
  end


  def play_again
    puts "Would you like to play again? y/n"
    choice = gets.strip
    if choice == "n"
      puts "Thanks for playing and have a great day!"
    elsif choice == "y"
      @displayed_toilets = []
      GameOfThrones::Controller.new.make_selection
    else
      puts "please type in 'y' or 'n' to make your selection."
      play_again
    end
  end


end
