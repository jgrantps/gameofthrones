class GameOfThrones::Categories

  attr_accessor :name, :url, :index, :toilets

  @@all = []

 def initialize(name, url, index)
   @url = url
   @name = name
   @index = index
   @toilets = []
   @@all<<self
 end

 def self.all
   @@all
 end

end
