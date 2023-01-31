class Player
  attr_accessor :name, :life_points

  def initialize (nom)
    @name = nom
    @life_points = 10
  end

  def show_state
    puts "#{name} a #{@life_points} point(s) de vie"
  end

  def gets_damage(damage_received)
    @life_points -= damage_received
    puts "#{name} a été tué !" if @life_points <= 0
  end

  def attacks(target)
    puts "#{name} attaque #{target.name} !"
    damage_inflicted = self.compute_damage
    puts "#{name} inflige #{damage_inflicted} dégats !"
    target.gets_damage(damage_inflicted)
  end

  def still_alive?
    (@life_points > 0)
  end

  private 

  def compute_damage
    rand(1..6)
  end

  
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(nom)
    super(nom)
    @weapon_level = 1
    @life_points = 100
  end

  def search_weapon
    dice = rand(1..6)
    if dice > weapon_level 
      @weapon_level = dice
      puts "Ta nouvelle arme est niveau #{weapon_level} !"
    else
      puts "Tu preferes garder ton arme :("
    end
  end

  def search_health_pack
    dice = rand(1..6)
    if dice == 1
      puts "Tu n'as rien trouvé :("
    elsif  dice == 6
      @life_points += 80
      @life_points = 100 if @life_points > 100
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    else
      @life_points += 50
      @life_points = 100 if @life_points > 100
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    end
  end
  
  private 

  def compute_damage
    rand(1..6) * @weapon_level
  end

end