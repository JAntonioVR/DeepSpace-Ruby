
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module Deepspace
  class SuppliesPackage
    
    attr_reader :ammoPower, :fuelUnits, :shieldPower
    
    public
    
    def initialize(ap, fu, sp)
      @ammoPower = ap
      @fuelUnits = fu
      @shieldPower = sp
    end
    
    def self.newCopy(s)
      @ammoPower = s.ammoPower
      @fuelUnits = s.fuelUnits
      @shieldPower = s.shieldPower
    end
    
    def to_s
      return "Potencia de disparo: "+@ammoPower+"\nUnidades de combustible: "+@fuelUnits+
        "\nPotencia de escudo: "+@shieldPower
    end
    
  end
end
