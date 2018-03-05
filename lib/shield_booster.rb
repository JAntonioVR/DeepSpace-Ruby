
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module DeepSpace
  class ShieldBooster
   attr_reader :boost, :uses
    
   def initialize(new_name, new_boost, new_uses)
      @name = name
      @boost = boost
      @uses = uses
   end
    
   def newCopy(s)
      @name = s.name
      @boost = s.boost
      @uses = s.uses
   end
   
   def useIt()
     if @uses > 0
       @uses = @uses - 1
       return @boost
     else
       return 1.0
     end
   end
   
   
  end
end
