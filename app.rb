require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

josiane = Player.new("Josiane")
jose = Player.new("José")

while (jose.life_points > 0) && (josiane.life_points > 0)
  jose.show_state
  josiane.show_state
  puts "Passons à la phase d'attaque :"
  josiane.attacks(jose)
  jose.attacks(josiane) unless jose.life_points <= 0
  puts
end
