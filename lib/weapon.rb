
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module DeepSpace
  class Weapon
    
    attr_reader :type, :uses
    
    def initialize(new_name, new_type, new_uses)
      @name = name
      @type = type
      @uses = uses
    end
   
    def newCopy(s)
      @name = s.name
      @type = s.type
      @uses = s.uses
    end
    
    def power()
      return @type.power
    end
    
    def useIt()
     if @uses > 0
       @uses = @uses - 1
       return power
     else
       return 1.0
     end
   end
    
  end
end
