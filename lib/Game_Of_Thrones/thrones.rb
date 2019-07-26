class GameOfThrones::Thrones
  attr_accessor :name, :price, :url, :index, :category
  @@all = []
  def initialize(name, price, url, index, category)
    @name = name
    @price = price
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
