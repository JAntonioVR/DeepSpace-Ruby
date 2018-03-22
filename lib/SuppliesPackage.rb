
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
    
    def newCopy(s)
      @ammoPower = s.ap
      @fuelUnits = s.fu
      @shieldPower = s.sp
    end
    
    def to_s
      return "Potencia de disparo: "+@ammoPower+"\nUnidades de combustible: "+@fuelUnits+
        "\nPotencia de escudo: "+@shieldPower
    end
    
  end
end
