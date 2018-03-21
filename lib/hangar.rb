
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

require_relative "weapon"
require_relative "shield_booster"

module DeepSpace
  class Hangar
    attr_reader :maxElements, :shieldBooster, :weapons
  
    public
  
    def initialize
        @maxElements=0
        @shieldBooster=[]
        @weapons=[]
    end
    
    def newHangar(c)
      @maxElements=c
    end
    
    def newCopy(h)
      @maxElements=h.maxElements
      @shieldBooster=h.shieldBooster
      @weapons=h.weapons
    end
    
    def getUIversion
      return HangarToUI.new(self)
    end
    
    private
    def spaceAvaliable
      return (@shieldBooster.length+@weapons.length)<@maxElements
    end
    
    public
    def addWeapon(w)
      @weapons.push(w) if self.spaceAvaiable
    end

    def addShieldBooster(s)
      @shieldBooster.push(s) if self.spaceAvaiable
    end
    
    def removeWeapon(w)
      if w<=@weapons.length
          removed=@weapons.pop(w)
          return remove
      else
          return null
      end
    end
    
    def removeShieldBooster(s)
      if s<=@shieldBooster.length
        removed=@weapons.pop(s)
        return removed
      else
        return null
      end
    end
    
    def to_s
      return "Esta instancia de la clase Hangar contiene "+@weapons.to_s+
             " armas y "+@shieldBoosters.to_s+" potenciadores de escudo y puede almacenar "
              +@maxElements+ " elementos."
    end
    
  end
end