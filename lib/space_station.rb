
#@author Pedro Pablo Ruiz Huertas y Juan Antonio Villegas Recio

#encoding:utf-8
requires_relative "supplies_package"
requires_relative "hangar"
requires_relative "damage"

module DeepSpace
  class SpaceStation
    @@MAXFUEL=100
    @@SHIELDLOSSPERUNITSHOT=0.1
    
    attr_reader :name, :ammoPower, :fuelUnits,
      :nMedals, :shieldPower, :pendingDamage,
      :weapons, :shieldBoosters, :hangar
    
    
    def initialize(n,s)
      @name=n
      @ammoPower=s.getAmmoPower
      @fuelUnits=s.getFuelUnits
      @nMedals=0
      @shieldPower=s.getShieldPower
      @pendingDamage=damage.new
      @weapons=[]
      @shieldBoosters=[]
      @hangar=nil
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
      i=0
      until i=@weapons.length
        @weapons.pop
        i=i+1
      end
      i=0
      until i=@shieldBoosters.length
        @shieldBoosters.pop
        i=i+1
      end
    end
    
    def getSpeed
      return @fuelUnits/@@MAXFUEL
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
    
    def mountWeapons(i)
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
    
    def receiveShieldBooser(s)
      if @hangar==nil
        return false
      else
        @hangar.shieldBoosters.push(s)
      end
    end
    
    def receiveShot
      
    end
    
    def receiveSupplies(s)
      @ammoPower=@ammoPower+s.getAmmoPower
      @fuelUnits=@fuelUnits+s.getFuelUnits
      @shieldPower=@shieldPower+s.getShieldPower
    end
    
    def receiveWeapon(w)
      if @hangar==nil
        return false
      else
        @hangar.weapons.push(w)
      end
    end
    
    def setLoot
      
    end
    
    def setPendingDamage(d)
      return @pendingDamage=d.adjust(@weapons, @shieldBoosters)
    end
    
    def validState
      return @pendingDamage==nil || @pendingDamage.hasNoEffect
    end
    
    def to_s
      return "La estacion espacial tiene: \n*Una potencia de disparo de "+@ammoPower+
              "\n*"+@fuelUnits+" Unidades de combustible \n*"+@nMedals+" medallas \n*Una potencia de escudo de "+
              @shieldPower + "\nSu nombre es: " + @name + "\nARMAS:\n"+@weapons.to_s+"\nPOTENCIADORES DE ESCUDO:\n"
              +@shieldBoosters.to_s+"\nDaño pendiente: "+@pendingDamage.to_s+"\nHangar: "+@hangar.to_s;
    end
    
  end
end
