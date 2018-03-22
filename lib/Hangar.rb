
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

require_relative "Weapon"
require_relative "ShieldBooster"

module Deepspace
  class Hangar
    attr_reader :maxElements, :shieldBoosters, :weapons
  
    public
  
    def initialize(capacity)
        @maxElements=capacity
        @shieldBoosters=Array.new
        @weapons=Array.new
    end
    
    def self.newCopy(h)
      hangarAux=new(h.maxElements)
      h.shieldBoosters.each { |potenciador|
        hangarAux.shieldBoosters.push(potenciador)
      }
      h.weapons.each{ |arma|
        hangarAux.weapons.push(arma)
      }
      return hangarAux
    end
    
    def getUIversion
      return HangarToUI.new(self)
    end
    
    private
    def spaceAvailable
      return (@shieldBoosters.length+@weapons.length)<@maxElements
    end
    
    public
    def addWeapon(w)
      @weapons.push(w) if spaceAvailable
    end

    def addShieldBooster(s)
      @shieldBoosters.push(s) if spaceAvailable
    end
    
    def removeWeapon(w)
      if w<@weapons.length
          removed=@weapons[w]
          @weapons.delete_at(w)
          return removed
      else
          return nil
      end
    end
    
    def removeShieldBooster(s)
      if s<@shieldBoosters.length
        removed=@shieldBoosters[s]
        @shieldBoosters.delete_at(s)
        return removed
      else
        return nil
      end
    end
    
    def to_s
      cad= "Armas: \n"
      weapons.each{ |arma|
        cad+=arma.to_s
      }
      cad+="\nPotenciadores de escudo:\n"
      shieldBoosters.each{ |potenciador|
        cad+=potenciador.to_s
      }
      cad+="\nPuede almacenar #{@maxElements} elementos."
      
      return cad
    end
    
  end
end
