class GameOfThrones::ThroneScraper

  def initialize

  end

  def thrones_scraper(var)
    @toilet_url = []
    subpage = Nokogiri::HTML(open(var))
    subproducts = subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")
    count = 1
    subproducts.each do |t|
      GameOfThrones::Thrones.new(t.css("p.product-panel__summary.product-panel__summary-new").text, t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip, t.css("https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?")), count)
      count += 1
    end
    @toilet_url = subproducts.collect {|t| "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?")}
    @toilet_names = subproducts.collect {|t| t.css("p.product-panel__summary.product-panel__summary-new").text}
    @toilet_prices = subproducts.collect {|t| t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip}

   #  binding.pry
   guess
  end
end
