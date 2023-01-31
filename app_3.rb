require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

my_game = Game.new
while my_game.still_going?
  my_game.show_players
  my_game.human_turn
  my_game.enemies_turn
end
my_game.end
