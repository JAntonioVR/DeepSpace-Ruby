
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

requires_relative "Dice"

module Deepspace
  class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation
    
    @@EXTRAEFFICIENCY=1.2
    @dice=Dice.new
   
    def initialize(station)
      super
    end
    
    def fire
      if(@dice.extraEfficiency==1)
        factor=super*@@EXTRAEFFICIENCY
        return factor
      else return super
      end
    end
  end
end
