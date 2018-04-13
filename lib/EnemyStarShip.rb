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
    
    def self.newCopy(e)
      new(e.damage,e.loot,e.ammoPower,e.name,e.shieldPower)
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
      return "Dano: "+@damage.to_s+"\nBotin: "+@loot.to_s+"\nNombre: #{@name}, \nEnergia del escudo: #{@shieldPower},  \nPotencia de disparo: #{@ammoPower}"
    end
    
  end
end

