class GameOfThrones::Category
  require 'nokogiri'
require 'open-uri'

    def initialize
    end

  def category_controller
    site = "https://www.us.kohler.com/us/toilets/article/CNT125900002.htm"
    page = Nokogiri::HTML(open(site))
    products = page.css("div.col-6-lg.col-6-md.col-12-sm.main-text-content")
    @category_urls = products.collect {|t| "https://kohler.com"+t.css("a").attr("href").value}
    @category_titles = products.collect { |t| t.css("div.main-text-content h3").text}
    bob = @category_titles.zip(@category_urls)

    binding.pry
  end

end
