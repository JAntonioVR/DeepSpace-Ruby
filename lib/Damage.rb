# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "WeaponType"
require_relative "Weapon"
require_relative "DamageToUI"

module Deepspace
  
  class Damage
    
    attr_reader :nShields
    
    def initialize(s)
      @nShields=s
    end
    
    public  
    def getUIversion
      return DamageToUI.new(self)
    end
    
    def adjust(w,s)
    end
    
    def adjustShieldBoosters(s)
      return [s.length,@nShields].min
    end
    
    def discardWeapon(w)
    end
    
    def discardShieldBooster
      if @nShields>0
        @nShields=@nShields-1
      end
    end
    
    def hasNoEffect
      return @nShields==0
    end
    
    private_class_method :new
  end
  
end


