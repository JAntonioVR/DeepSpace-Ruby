# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "Damage"

module Deepspace
  class SpecificDamage < Damage
    
    public_class_method :new    
    
    attr_reader :weapons
    
    def initialize(w,s)
      super(s)
      @weapons=w
    end
    
    @override
    def adjust(w,s)
      vec=[]
        w.each{ |arma|
          vec.push(arma.type)
        }
        tipos=[]
        for i in (0..[vec.count(WeaponType::LASER),@weapons.count(WeaponType::LASER)].min-1) do
          tipos.push(WeaponType::LASER)
        end
        for i in (0..[vec.count(WeaponType::MISSILE),@weapons.count(WeaponType::MISSILE)].min-1) do
          tipos.push(WeaponType::MISSILE)
        end
        for i in (0..[vec.count(WeaponType::PLASMA),@weapons.count(WeaponType::PLASMA)].min-1) do
          tipos.push(WeaponType::PLASMA)
        end
      return SpecificDamage.new(tipos,adjustShieldBoosters(s))
    end
    
    def copy
      return SpecificDamage.new(@weapons,@nShields)
    end
  
    @override
    def discardWeapon(w)
      i=@weapons.index(w.type)
      if(i!=nil)
      @weapons.delete_at(i)
      end
    end
    
    @override
    def hasNoEffect
      return @weapons.length==0 && super
    end
    
    private
    def arrayContainsType(w,t)
      res=-1
      i=0
      w.each do |aux|
        res=i if aux.type==t
        i+=1
      end
      return res
    end
    
    public
    @override
    def to_s
      cad= "Dano Especifico: #{@nShields} escudos y los siguientes tipos: "
      @weapons.each{ |arma|
        if arma==WeaponType::LASER
          cad+="LASER  "
        elsif arma==WeaponType::PLASMA
          cad+="PLASMA  "
        else
          cad+="MISSILE  "
        end  
      }
      return cad  
    end
    
  end
end
