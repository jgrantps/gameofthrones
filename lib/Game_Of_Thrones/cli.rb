class GameOfThrones::CLI

  def call
    puts <<-DOC


<<<<****>>>>
Welcome to Game of Thrones!

Game of Thrones is a CLI game that uses the library of toilets made by Kohler international.

The game is simple:

1. First select the category of toilet - or "Throne" - you want to play in.  The game will randomly return 3 toilet choices.
2. Try and guess the most expensive of the three!

If you're stumped, you can ask to see more information (including the price - try not to cheat!) of your 3 toilet choices.

If at any time you wish to leave the game, simply type 'exit'.\n
  DOC
continue
GameOfThrones::Controller.new.start
end

  def continue
    puts "Press any key to continue..."
    input = gets.strip

  end
end
