# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Deepspace
  class SpaceCity < SpaceStation
    
    attr_reader :collaborators
    
    def initialize(base, rest)
      createStation(base)
      @collaborators=rest      
    end
    
    @override
    def fire
      disparo=super
      @collaborators.each{ |estacion|
        disparo+=estacion.fire
      }
      return disparo
    end
    
    @override
    def protection
      proteccion=super
      @collaborators.each{ |estacion|
        proteccion+=estacion.protection
      }
      return proteccion
    end
    
    @override
    def setLoot(loot)
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
      
      return Transformation::NOTRANSFORM
      
    end
    
    def to_s
      cad="ESTACION BASE:"+super+"\nCOLABORADORES:"
      @collaborators.each { |colaborador|
        cad+=colaborador.to_s
      }
      return cad
    end
    
    
  end
end
