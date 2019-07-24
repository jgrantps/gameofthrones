class GameOfThrones::Controller
  @@h = {}
  def self.category_scraper             #=> scrapes for two components of the toilet categories: title and URL.
    site = "https://www.us.kohler.com/us/toilets/article/CNT125900002.htm"
    page = Nokogiri::HTML(open(site))
    products = page.css("div.col-6-lg.col-6-md.col-12-sm.main-text-content")

    products.each do |t|
      GameOfThrones::Categories.new(t.css("div.main-text-content h3").text, "https://www.us.kohler.com"+t.css("a").attr("href").value)
    end

    binding.pry
  end




  def self.hash_array
    @@category_titles.zip(@@category_urls)
  end

  def self.indexed_hash #=> returns the hash with the key: Value pairs as Index: URL
    count = 1
    @i = {}
    hash_array.map do |item|
      @i[count] = item[1]
      count +=1
    end
    @i
  end

  def self.title_hash #=> returns the hash with the key: Value pairs as Title: URL
    category_titles.zip(category_urls).map do |i|
      hash[i[0]] = i[1]
    end
    hash
  end #=> returns the hash with the key: Value pairs as title: URL

  def self.title_hash_invert
    title_hash.invert
  end

  def self.subselection #=> returns the list of categories to choose from.
    title_hash
    puts "choose your category:\n\n"
    count = 1
    hash.each do |key, value|
      puts "#{count}. #{key}"
      count += 1
    end
    hash
    make_selection
  end

  def self.selector(index)
    url = indexed_hash[index]
    name = title_hash_invert[url]

  end

  def self.make_selection
    @menu_selection = gets.strip.to_i
    selector(@menu_selection)
  end

end
