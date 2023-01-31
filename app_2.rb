require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"
puts
puts "Quel est ton nom gladiateur ? "
print ">"
player_name = gets.chomp
our_player = HumanPlayer.new(player_name)
enemies_array = []
enemies_array << Player.new("Josiane")
enemies_array << Player.new("José")

while our_player.life_points > 0 && (enemies_array[0].life_points > 0 || enemies_array[1].life_points > 0)
  our_player.show_state
  puts
  action = "n"
  while ["a", "s", "0", "1"].exclude?(action)
    puts "Choisis une action ! "
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "0 - Attaquer Josiane et ses  #{enemies_array[0].life_points} points de vie"
    puts "1 - Attaquer José et ses  #{enemies_array[1].life_points} points de vie"
    print ">"
    action = gets.chomp
  end
  case action
  when "a"
    our_player.search_weapon
  when "s"
    our_player.search_health_pack
  when "0"
    our_player.attacks(enemies_array[0])
  else
    our_player.attacks(enemies_array[1])
  end
  gets.chomp
  next unless enemies_array[0].still_alive? || enemies_array[1].still_alive?

  puts
  puts "C'est au tour de tes adversaires !"
  enemies_array.each{ |enemy|
    enemy.attacks(our_player) unless enemy.life_points <= 0
  }
  gets.chomp
end
our_player.life_points > 0 ? (puts "BRAVO TU AS VAINCU TES ADVERSAIRES !") : (puts "Loser ! Tu as perdu !")
