
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module Deepspace
  class PowerEfficientSpaceStation < SpaceStation
    
    @@EFFICIENCYFACTOR=1.1
    
    def initialize(station)
      createStation(station)
    end
    
    def fire
      factor=super*@@EFFICIENCYFACTOR
      return factor
    end
    
    def protection
      factor=super*@@EFFICIENCYFACTOR
      return factor
    end
    
    def setLoot
      dealer=CardDealer.instance
      
      h=loot.nHangars
      if h>0
        hangar=dealer.nextHangar
        receiveHangar(hangar)
      end
      
      elements=loot.nSupplies
      for i in 1..elements
        sup=dealer.nextSuppliesPackage
        receiveSupplies(sup)
      end
      
      elements=loot.nWeapons
      for j in 1..elements
        weap=dealer.nextWeapon
        receiveWeapon(weap)
      end
      
      elements=loot.nShields
      for k in 1..elements
        sh=dealer.nextShieldBooster
        receiveShieldBooster(sh)
      end
      
      medals=loot.nMedals
      @nMedals+=medals
      if loot.getEfficient
        return Transformation::GETEFFICIENCE
      else
        return Transformation::NOTRANSFORM
      end
    end
  end
end
