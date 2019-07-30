class GameOfThrones::Controller

  def initialize
    @displayed_toilets = []
  end

  def start
    category_scraper #=> returns set of catgory objects.
    make_selection #=> prompts the user to choose which category to play the round in.
  end


  def category_scraper #=> scrapes and returns title and URL for all toilet categories.
    site = "https://www.us.kohler.com/us/toilets/article/CNT125900002.htm"
    page = Nokogiri::HTML(open(site))
    products = page.css("div.col-6-lg.col-6-md.col-12-sm.main-text-content")
    if GameOfThrones::Categories.all == [] #=> scrapes only if the categories array has not yet been populated with scraped data.
      count = 1
      products.each do |t|
       GameOfThrones::Categories.new(t.css("div.main-text-content h3").text, "https://www.us.kohler.com"+t.css("a").attr("href").value, count)
       count += 1
      end
    end
  end

  def make_selection #=> prompts for and validates user entry for which category is to be used in the round.
    puts "Make a selection of which category you would like to explore:\n\n"
      GameOfThrones::Categories.all[0..3].each { |category| puts "#{category.index}. #{category.name}"} #=> puts out a list of the first 4 categories (the remaining categories are irrelevant)
      input = gets.strip #=> receives chosen index number from user.
       if ["1","2","3","4"].include? input #=> checks to confirm if the entry was valid.
      category = GameOfThrones::Categories.all.detect {|category| category.index == input.to_i } #=> sets the category variable to the selected category of toilet for rest of the gameplay.
      puts "You have selected:\n  #{category.name}"
      category_check(category)
     elsif input == "exit"
      puts "Thanks for playing!"
      return nil
     else
      puts "\nYou entered a typo!  Please choose again. \n\n"
      make_selection #=> loops the method until the user provides a valid response.
     end
  end

  def category_check(category) #=> scrapes for toilets if category's toilet attribute is empty.  Returns toilet attribute if not empty.
    if category.toilets == []
      thrones_scraper(category)
      guess(category)
    else
      guess(category)
    end
  end

  def thrones_scraper(category) #=> scrapes the category for its corresponding toilets.
    subpage = Nokogiri::HTML(open(category.url))
    subproducts = subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")

    count = 1
    if category.toilets == []#=> instantiates individual toilets that belong to the category, if it hasn't been done already.
     subproducts.each do |t|
       GameOfThrones::Thrones.new(t.css("p.product-panel__summary.product-panel__summary-new").text, t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip, "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?"), count, category)
       count += 1
     end
   end
  end

  def guess(category) #=> Prompts user for selection
    puts "\nGuess which throne you think is the most expensive by entering the corresponding index number."
    puts "To find out more info on each throne, enter the index number followed by a '?'\n\n"
    selection_generator(category) #=> displays toilet table for user to make a decision over.
    input_check #=> returns response based on if there is request for more details, a guess is made, or input is an error.
 end

 def selection_generator(category) #=> returns the list of 3 random toilets to choose from.
    category.toilets.sample(3).each do |toilet|
      puts "   #{toilet.index}. #{toilet.name}"
      @displayed_toilets << toilet #=> temporarily stores the generated selection in a dedicated array.
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
       input_check #=> loops the method until the user provides a valid response
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
   sorted_prices = @displayed_toilets.map { |t|  t.price_i }.sort {|a,b| b <=> a } #=> returns an array of the integer prices sorted from highest to lowest.

   if throne.price_i == sorted_prices.first #=> checks to see if the users selected toilet price matches the first item in the sorted array.
     puts "\nCongratulations!  You answered correctly."
     play_again
   else
     puts "Wrong!  Try again."
     input_check #=> loops the method until the user provides a valid response.
   end
 end


 def play_again #prompts user to choose to play another round or to exit.
   puts "Would you like to play again? y/n"
   choice = gets.strip

   if choice == "n"
     puts "Thanks for playing and have a great day!"
   elsif choice == "y"
     @displayed_toilets = [] #=> resets the @displayed_toilets variable, readying it for the being populated for the next round.
     make_selection #=> triggers the restart of general gameplay.
   else
     puts "please type in 'y' or 'n' to make your selection." #=> loops the method until the user provides a valid response y/n.
     play_again
   end
 end
end
