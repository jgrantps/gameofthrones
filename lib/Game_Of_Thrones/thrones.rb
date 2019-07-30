class GameOfThrones::Thrones
  attr_accessor :name, :price, :url, :index, :category, :price_i
  @@all = []
  def initialize(name, price, url, index, category)
    @name = name
    @price = price
    @price_i = price.gsub("$", "").gsub(",", "").to_i
    @url = url
    @index = index
    @category = category
    @@all<<self
    category.toilets << self
  end

  def self.all
    @@all
  end

end
