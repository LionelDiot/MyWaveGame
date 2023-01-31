require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/wave_game'

my_wave_game = WaveGame.new
while my_wave_game.is_still_going?
  my_wave_game.show_players
  my_wave_game.human_turn
  my_wave_game.enemies_turn if my_wave_game.is_still_going?
  my_wave_game.new_wave if my_wave_game.is_still_going?
  gets.chomp if my_wave_game.is_still_going?
end
my_wave_game.end
# pouet
