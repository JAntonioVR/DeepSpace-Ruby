
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8

module Deepspace
  class ShieldBooster
   attr_reader :boost, :uses
   
   public
   
   def initialize(new_name, new_boost, new_uses)
      @name = new_name
      @boost = new_boost
      @uses = new_uses
   end
    
   def newCopy(s)
      @name = s.name
      @boost = s.boost
      @uses = s.uses
   end
   
   def getUIversion
     return ShieldToUI.new(self)
   end
   
   def useIt()
     if @uses > 0
       @uses = @uses - 1
       return @boost
     else
       return 1.0
     end
   end
   
   def to_s
     return "Nombre: #{@name}  Aumento: #{@boost}  Usos: #{@uses}\n"
   end
   
   
  end
end
