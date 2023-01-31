require_relative 'player'
require_relative 'game'

class WaveGame < Game
  attr_accessor :our_player, :enemies_array, :all_enemies_array

  def initialize
    super
    @enemies_array = []
    @all_enemies_array = []
    set_all_enemies_array
    set_enemies_array
  end

  def still_going?
    @our_player.still_alive? && (!@enemies_array.empty? || !@all_enemies_array.empty?)
  end

  def new_wave
    if @all_enemies_array.empty?
      puts "Tue les derniers enemis présents pour remporter la victoire !"
    else
      dice = rand(1..6)
      if dice == 1
        puts "Aucun enemi ne t'a repéré, chanceux !"
      elsif  (@all_enemies_array.length > 1) && (dice == 6)
        enemy_arrives
        enemy_arrives
      else
        enemy_arrives
      end
    end
  end

  def show_players
    @our_player.show_state
    puts "#{@enemies_array.length} enemie(s) se battent contre toi et #{@all_enemies_array.length} ne sont pas très loin"
  end

  private

  def set_all_enemies_array
    puts "Combien d'enemies souhaites tu ?(1 ou +)"
    @nb_enemies = 0
    while @nb_enemies.to_i < 1
      print ">"
      @nb_enemies = gets.chomp.to_i
    end
    puts "Donne leur tous un nom !"
    i = 0
    @nb_enemies.times do
      enemy_name = ""
      while enemy_name == ""
        print "Nomme ton enemi n°#{i} :"
        enemy_name = gets.chomp
      end
      enemy_instance = Player.new(enemy_name)
      @all_enemies_array << enemy_instance
      i += 1
    end
    puts
  end

  def enemy_arrives
    return if @all_enemies_array.empty?

    @enemies_array << @all_enemies_array[0]
    puts "#{@all_enemies_array[0].name} vient se battre !"
    @all_enemies_array.delete_at(0)
  end

  def set_enemies_array
    puts "Les enemis t'ont entendu atterrir ils pourraient arriver de tous les côtés ! "
    puts "A droite ? "
    new_wave
    gets.chomp
    puts "A gauche ? "
    new_wave
    gets.chomp
  end
end
