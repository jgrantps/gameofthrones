class GameOfThrones::SubCategories
  attr_accessor :url
  def initialize(url)
    @url = url
    puts "hello from subcategories"
    puts "this is from categories #{url}"
    toilet_scraper
  end

  def toilet_scraper
    @toilet_url = []
    product = Nokogiri::HTML(open(@url))
    details = product.css("div.product-detail__specs-container.col-8-md.pad-r-15-sm pad-r-40-md")
    overview = product.css("product-detail__name-and-description product-detail__name.pd-name").text
    #summary = overview.css()
    binding.pry
    # @toilet_url = subproducts.collect {|t| "https://www.us.kohler.com"+t.css("a").attr("href").value.gsub("s.jsp?productId=","/toilets/").gsub("?",".htm?")}
    # @toilet_name = subproducts.collect {|t| t.css("p.product-panel__summary.product-panel__summary-new").text}
    # @toilet_price = subproducts.collect {|t| t.css("p.product-panel__price.product-panel__price-new.light-gray--sku--price").text.gsub("Starting at ","").strip}

   end
end
