#encoding:utf-8


require_relative "EnemyToUI"
require_relative "Damage"
require_relative "Loot"
require_relative "ShotResult"

module Deepspace
  class EnemyStarShip
    
    attr_reader :ammoPower, :name, :shieldPower, :loot, :damage
    public
    
    def initialize(n,a,s,l,d)
      @damage=d
      @loot=l
      @ammoPower=a
      @name=n
      @shieldPower=s
    end
    
    def new_copy(e)
      @damage=e.damage
      @loot=e.loot
      @ammoPower=e.ammoPower
      @name=e.name
      @shieldPower=s.shieldPower
    end
    
    def getUIversion
      return EnemyToUI.new(self)
    end
    
    def fire
      return @ammoPower
    end
    
    def protection
      return @shieldPower
    end
    
    def receiveShot(shot)
      if @shieldPower<shot
        return ShotResult::DONOTRESIST
      else
        return ShotResult::RESIST
      end
    end
    
    def to_s
      return "Dano: "+@damage.to_s+"Botin: "+@loot.to_s+"Nombre: #{@name},  Energia del escudo: #{@shieldPower},  Potencia de disparo: #{@ammoPower}"
    end
    
  end
end

