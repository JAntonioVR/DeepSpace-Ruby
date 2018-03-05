
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module DeepSpace
  class Loot
    
    attr_reader :nSupllies, :nWeapons, :nShields, :nHangars, :nMedals
    
    def initialize(new_nSupllies, new_nWeapons, new_nShields, new_nHangars, new_nMedals)
      @nSupllies = nSupllies
      @nWeapons = nWeapons
      @nShields = nShields
      @nHangars = nHangars
      @nMedals = nMedals
    end
    
    
    
  end
end
