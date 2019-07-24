class GameOfThrones::Controller

  def self.category_scraper             #=> scrapes for two components of the toilet categories: title and URL.
    site = "https://www.us.kohler.com/us/toilets/article/CNT125900002.htm"
    page = Nokogiri::HTML(open(site))
    products = page.css("div.col-6-lg.col-6-md.col-12-sm.main-text-content")
    count = 1
    products.each do |t|
      GameOfThrones::Categories.new(t.css("div.main-text-content h3").text, "https://www.us.kohler.com"+t.css("a").attr("href").value, count)
      count += 1
    end
    binding.pry
  end

  # def self.selector(index)
  #   url = indexed_hash[index]
  #   name = title_hash_invert[url]
  # end
  #
  # def self.make_selection
  #   @menu_selection = gets.strip.to_i
  #   selector(@menu_selection)
  # end

end
