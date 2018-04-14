# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "WeaponType"
require_relative "Weapon"
require_relative "DamageToUI"

module Deepspace
  class Damage
    
    attr_reader :nShields, :nWeapons, :weapons
    
    public
    
    def initialize(w,s,ws)
      @nShields=s
      @nWeapons=w
      @weapons=ws
    end
    
    def self.newNumericWeapons(w,s)
      self.new(w,s,[])
    end
    
    def self.newSpecificWeapons(wl,s)
      self.new(-1,s,wl)  
    end
    
    def self.newCopy(d)
      return new(d.nWeapons,d.nShields,d.weapons)
    end
    
    def getUIversion
      return DamageToUI.new(self)
    end
    
    def adjust(w,s)
      if @weapons==nil
        return Damage.newNumericWeapons([@nWeapons, w.length].min,[@nShields, s.length].min)
      else
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
        
        
        return Damage.newSpecificWeapons(tipos,[@nShields, s.length].min)
      end
    end
    
    def discardWeapon(w)
      if @weapons!=nil
        @weapons.delete(w.type)
      else
        if @nWeapons>0
        @nWeapons-=1
        end
      end 
    end
    
    def discardShieldBooster
      if @nShields>0
        @nShields-=1
      end
    end
    
    def hasNoEffect
      if @nShields==0 && (@nWeapons==0 || @weapons.length==0)
        return true
      else
        return false
      end
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
    
    def to_s
      if @nWeapons==-1
        cad= "\nNumero de escudos: #{@nShields}  Tipos de armas:"
        @weapons.each { |tipo|
          if(tipo==WeaponType::MISSILE)
            cad=cad+"MISSILE  "
          elsif(tipo==WeaponType::PLASMA)
            cad=cad+"PLASMA  "
          else
            cad=cad+"LASER  "
          end
        }
        return cad+"\n"
      else
        return "\nNumero de escudos: #{@nShields}  Numero de armas: #{@nWeapons}\n"
      end
    end

  end
end


