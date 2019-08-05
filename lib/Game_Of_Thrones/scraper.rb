class GameOfThrones::Scraper

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
end
