#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module Deepspace

  module WeaponType

      class Type

        def initialize(new_power)
          @power=new_power
        end

        def power
          @power
        end

      end

      LASER=Type.new(2.0)
      MISSILE=Type.new(3.0)
      PLASMA=Type.new(4.0)

  end

end