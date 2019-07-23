class GameOfThrones::CLI

  def call
    puts <<-DOC
<<<<****>>>>
Welcome to Game of Thrones!

Game of Thrones is a CLI game based off of a searchable library of toilets made by Kohler international.

The game is simple: pick a category of toilet - or "Throne" -  and then try to guess the most expensive one based on the desciptions!
You can read more details about the thrones in each category by simply entering their index number.

Make your guess by entering 'guess ##' to see if you were correct.\n\n
  DOC
GameOfThrones::Controller.category_scraper
  end



end
