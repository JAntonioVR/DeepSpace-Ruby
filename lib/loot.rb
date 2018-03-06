
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module DeepSpace
  class Loot
    
    attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals
    
    def initialize(new_nSupplies, new_nWeapons, new_nShields, new_nHangars, new_nMedals)
      @nSupplies = new_nSupplies
      @nWeapons = new_nWeapons
      @nShields = new_nShields
      @nHangars = new_nHangars
      @nMedals = new_nMedals
    end
    
    
    
  end
end
