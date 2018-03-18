
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module Deepspace
  class Loot
    
    attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals
    
    public
    
    def initialize(nsu, nw, nsh, nh, nm)
      @nSupplies = nsu
      @nWeapons = nw
      @nShields = nsh
      @nHangars = nh
      @nMedals = nm
    end
    
    def to_s
        mensaje = "El numero de suplementos es "+@nSupplies+
                ", el numero de armas es "+@nWeapons+
                ", el numero de escudos es "+@nShields+
                ", el numero de hangares es "+@nHangars+
                " y el numero de medallas es "+@nMedals
        return mensaje;
    end

  end
end
