
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module DeepSpace
  class SuplliesPackage
    
    attr_reader :ammoPower, :fuelUnits, :shieldPower
    
    def initialize(new_ammoPower, new_fuelUnits, new_shieldPower)
      @ammoPower = ammoPower
      @fuelUnits = fuelUnits
      @shieldPower = shieldPower
    end
    
    def newCopy(s)
      @ammoPower = s.ammoPower
      @fuelUnits = s.fuelUnits
      @shieldPower = s.shieldPower
    end
    
    
    
  end
end
