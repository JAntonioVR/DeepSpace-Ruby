# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Deepspace
  class SpaceCity < SpaceStation
    
    attr_reader :collaborators
    
    def initialize(base, rest)
      @base=base
      @collaborators=rest      
    end
    
    @override
    def fire
      disparo=@base.fire
      @collaborators.each{ |estacion|
        disparo+=estacion.fire
      }
      return disparo
    end
    
    
    
  end
end
