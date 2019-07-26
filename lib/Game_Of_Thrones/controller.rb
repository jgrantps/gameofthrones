class GameOfThrones::Controller

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
    products.each do |t|
      GameOfThrones::Categories.new(t.css("div.main-text-content h3").text, "https://www.us.kohler.com"+t.css("a").attr("href").value, count)
      count += 1
    end

  end

  def make_selection

    puts "make a selection of which category you'd like to explore:"
    GameOfThrones::Categories.all.each do |category|
      puts "#{category.index}. #{category.name}"
    end
    input = gets.strip.to_i

  category = GameOfThrones::Categories.all.detect {|category| category.index == input }


  category.thrones_scraper
  category.guess
  end



end
