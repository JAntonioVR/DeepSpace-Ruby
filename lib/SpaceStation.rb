
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8
require_relative "SuppliesPackage"
require_relative "Hangar"
require_relative "Damage"

module Deepspace
  class SpaceStation
    @@MAXFUEL=100
    @@SHIELDLOSSPERUNITSHOT=0.1
    
    attr_reader :name, :ammoPower, :fuelUnits,
      :nMedals, :shieldPower, :pendingDamage,
      :weapons, :shieldBoosters, :hangar
    
    
    def initialize(n,s)
      @name=n
      @ammoPower=s.ammoPower
      @nMedals=0
      @shieldPower=s.shieldPower
      @pendingDamage=nil
      @weapons=[]
      @shieldBoosters=[]
      @hangar=nil
      assignFuelValue(s.fuelUnits)
    end
    
    private
    def assignFuelValue(f)
      if f>@@MAXFUEL
        @fuelUnits=@@MAXFUEL
      else
        @fuelUnits=f
      end
    end
    
    def cleanPendingDamage
      @pendingDamage=null if @pendingDamage.hasNoEffect
    end
    
    public
    
    def getUIversion
      return SpaceStationToUI.new(self)
    end
    
    def cleanUpMountedItems
      aux=[]
      @weapons.each { |arma|
        if arma.uses==0
          aux.push(arma)
        end
      }
      aux.each { |obj| @weapons.delete(obj)  }
      aux=[]
      @shieldBoosters.each{ |potenciador|
        if potenciador.uses==0
          aux.push(potenciador)
        end
      }
      aux.each { |obj| @shieldBoosters.delete(obj)}
    end
    
    def getSpeed
      return @fuelUnits.to_f/@@MAXFUEL.to_f
    end
    
    def discardHangar
      @hangar=nil
    end
    
    def discardShieldBooster(i)
      
    end
    
    def discardShieldBoosterInHangar(i)
      if @hangar!=nil
        @hangar.removeShieldBooster(i)
      end
    end
    
    def discardWeapon(i)
      
    end
    
    def discardWeaponInHangar(i)
      if @hangar!=nil
        @hangar.removeWeapon(i)
      end
    end
    
    def mountShieldBooster(i)
      if @hangar!=nil
        aux=@hangar.shieldBoosters[i]
        @hangar.shieldBoosters.delete_at(i)
        if aux!=nil
          @shieldBoosters.push(aux)
        end
      end
    end
    
    def mountWeapon(i)
      if @hangar!=nil
        aux=@hangar.weapons[i]
        @hangar.weapons.delete_at(i)
        if aux!=nil
          @weapons.push(aux)
        end
      end
    end
    
    def move
      @fuelUnits=@fuelUnits-(@fuelUnits*getSpeed)
      if @fuelUnits<0
        @fuelUnits=0
      end
    end
    
    def protection
      
    end
    
    def receiveHangar(h)
      if @hangar==nil
        @hangar=h
      end
    end
    
    def receiveShieldBooster(s)
      if @hangar==nil
        return false
      else
        return @hangar.addShieldBooster(s)
      end
    end
    
    def receiveShot
      
    end
    
    def receiveSupplies(s)
      @ammoPower=@ammoPower+s.ammoPower
      @shieldPower=@shieldPower+s.shieldPower
      if(@fuelUnits+s.fuelUnits>@@MAXFUEL)
        @fuelUnits=@@MAXFUEL
      else
        @fuelUnits=@fuelUnits+s.fuelUnits
      end
    end
    
    def receiveWeapon(w)
      if @hangar==nil
        return false
      else
        return @hangar.addWeapon(w)
      end
    end
    
    def setLoot
      
    end
    
    def setPendingDamage(d)
      @pendingDamage=d.adjust(@weapons, @shieldBoosters)
    end
    
    def validState
      return @pendingDamage==nil || @pendingDamage.hasNoEffect
    end
    
    def to_s
      cad= "La estacion espacial tiene: \n*Una potencia de disparo de #{@ammoPower}\n*#{@fuelUnits} Unidades de combustible\n*"+
        "#{@nMedals} medallas\n*Una potencia de escudo de #{@shieldPower}\nSu nombre es: #{@name}"+
        "\nARMAS:\n"
        @weapons.each{ |arma|
        cad+=arma.to_s
      }
      cad+="\nPOTENCIADORES DE ESCUDO:\n"
        @shieldBoosters.each{ |potenciador|
        cad+=potenciador.to_s
      }
      cad+="\nDano pendiente:"+@pendingDamage.to_s+"\nHangar: \n"
      if(@hangar!=nil)
        cad+=@hangar.to_s
      else
        cad+="No tiene\n"
      end
      return cad
    end
    
  end
end
