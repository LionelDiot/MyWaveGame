require_relative 'player'

class Game
  attr_accessor :our_player, :enemies_array

  def initialize
    puts "------------------------------------------------"
    puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
    puts "|Le but du jeu est d'être le dernier survivant !|"
    puts "-------------------------------------------------"
    puts
    puts "Quel est ton nom gladiateur ? "
    print ">"
    player_name = gets.chomp
    @our_player = HumanPlayer.new(player_name)
    @enemies_array = []
    @enemies_array << Player.new("Josiane")
    @enemies_array << Player.new("José")
    @enemies_array << Player.new("John")
    @enemies_array << Player.new("Jean")
  end

  def kill_player(dead_enemy)
    @enemies_array.delete_if { |enemy| enemy.name == dead_enemy.name }
  end

  def still_going?
    (!@enemies_array.empty? && @our_player.still_alive?)
  end

  def show_players
    @our_player.show_state
    puts "Il reste #{@enemies_array.length} enemie(s) en vie !"
  end

  def human_turn
    action = "0" # on test que l'utilisateur rentre bien une des options du menu (sinon on loop)
    until ((action.to_i > 0) && (action.to_i <= @enemies_array.length)) || (action == "a") || (action == "s")
      print_menu
      action = gets.chomp
    end
    case action
    when "a"
      @our_player.search_weapon
    when "s"
      @our_player.search_health_pack
    else
      @our_player.attacks(@enemies_array[action.to_i - 1])
      kill_player(@enemies_array[action.to_i - 1]) unless @enemies_array[action.to_i - 1].still_alive?
    end
    gets.chomp
  end

  def enemies_turn
    @enemies_array.each { |enemy|
      enemy.attacks(@our_player) if our_player.still_alive?
    }
    gets.chomp if our_player.still_alive?
  end

  def end
    puts
    puts "------------------------------------------------"
    puts "        La partie est finie : #{@our_player.name}"
    our_player.still_alive? ? (puts "        BRAVO TU ES LE DERNIER SURVIVANT") : (puts "       RIP TU ES MORT, RETENTE TA CHANCE")
    puts "-------------------------------------------------"
  end

  private

  def print_menu
    puts "Choisis une action ! "
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"
    @enemies_array.each_with_index { |enemy, index|
      puts "#{index + 1} - #{enemy.name} a #{enemy.life_points} points de vie" if enemy.still_alive?
    }
    print ">"
  end
end
