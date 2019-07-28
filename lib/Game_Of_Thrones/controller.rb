class GameOfThrones::Controller

  def initialize

  end

  def start

    category_scraper #=> returns set of catgory objects.
    make_selection
  end

#=> scrapes for two components of the toilet categories: title and URL.
#=> returns a new category object with thrones array = nil.
  def category_scraper
    site = "https://www.us.kohler.com/us/toilets/article/CNT125900002.htm"
    page = Nokogiri::HTML(open(site))
    products = page.css("div.col-6-lg.col-6-md.col-12-sm.main-text-content")
    count = 1
     if GameOfThrones::Categories.all == []
      products.each do |t|
        GameOfThrones::Categories.new(t.css("div.main-text-content h3").text, "https://www.us.kohler.com"+t.css("a").attr("href").value, count)
        count += 1
     end
  end
  # binding.pry

  end

  def make_selection
    puts "Make a selection of which category you'd like to explore:\n\n"
  #=> puts out a list of all the categories.
    GameOfThrones::Categories.all[0..3].each do |category|
      puts "#{category.index}. #{category.name}"
    end
  #=> receives chosen index number from user.
    input = gets.strip
  #=> checks to confirm if the entry was valid.
     if ["1","2","3","4"].include? input
      category = GameOfThrones::Categories.all.detect {|category| category.index == input.to_i }

      puts "You have selected:\n  #{category.name}"
      category_check(category)
      # category.thrones_scraper
      # category.guess
     else
      puts "\n******************\nYou have entered an error!  Please choose again. \n\n"
      make_selection
     end
  end

#=> scrapes for toilets if toilet attribute is empty.  Returns toilet attribute if not empty.
  def category_check(var)
    if var.toilets == []
      var.thrones_scraper
      var.guess
    else
      var.guess
    end
  end

end
