
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

require_relative "Weapon"
require_relative "ShieldBooster"

module DeepSpace
  class Hangar
    attr_reader :maxElements, :shieldBoosters, :weapons
  
    public
  
    def initialize
        @maxElements=0
        @shieldBoosters=[]
        @weapons=[]
    end
    
    def newHangar(c)
      @maxElements=c
    end
    
    def newCopy(h)
      @maxElements=h.maxElements
      @shieldBoosters=h.shieldBoosters
      @weapons=h.weapons
    end
    
    def getUIversion
      return HangarToUI.new(self)
    end
    
    private
    def spaceAvaliable
      return (@shieldBoosters.length+@weapons.length)<@maxElements
    end
    
    public
    def addWeapon(w)
      @weapons.push(w) if self.spaceAvaiable
    end

    def addShieldBooster(s)
      @shieldBoosters.push(s) if self.spaceAvaiable
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
      return "Esta instancia de la clase Hangar contiene "+@weapons.to_s+
             " armas y "+@shieldBoosters.to_s+" potenciadores de escudo y puede almacenar "
              +@maxElements+ " elementos."
    end
    
  end
end