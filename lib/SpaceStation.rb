
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
      @pendingDamage=nil if @pendingDamage.hasNoEffect
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
      if i>=0 && i<@weapons.length
        w=@weapons.remove(i)
        if @pendingDamage!=nil
          @pendingDamage.discardWeapon(w)
          cleanPendingDamage
        end
      end
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
    
    def fire
      factor=1
      for i in 0..@weapons.length
        w=@weapons.at(i)
        factor=factor*w.useIt  
      end
      return @ammoPower*factor
    end
    
    def protection
      factor=1
      for i in 0..@shieldBoosters.length
        s=@shieldBoosters.at(i)
        factor=factor*s.useIt  
      end
      return @shieldPower*factor
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
    
<<<<<<< HEAD
    def fire
      factor=1
      print @weapons.to_s
      for i in 0..@weapons.length
        w=@weapons.at(i)
        factor=factor*w.useIt  
      end
      return @ammoPower*factor
    end
    
=======
>>>>>>> 18eb021669a5ffd14348e30afebf67baf08fa59c
    def receiveShot(shot)
      myProtection=protection
      @shieldpower=@shieldpower-@@SHIELDLOSSPERUNITSHOT*shot
      @shieldpower=[0.0, @shieldpower].max
      if @shieldpower>0.0
        return ShotResult::RESIST
      else
        return ShotResult::DONOTRESIST
      end  
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
    
    def setLoot(loot)
      dealer.instance
      h=loot.nHangars
      if h>0
        hangar=dealer.nextHangar
        receiveHangar(hangar)
      end
      
      elements=loot.getNSupplies
      for i in 1..elements
        sup=dealer.nextSupplies
        receiveSupplies(sup)
      end
      
      elements=loot.getNWeapons
      for i in 1..elements
        weap=dealer.nextWeapon
        receiveWeapons(weap)
      end
      
      elements=loot.getNShields
      for i in 1..elements
        sh=dealer.nextShieldBooster
        receiveShieldBooster(sh)
      end
      
      medals=loot.getNMedals
      @nMedals=@nMedals+medals
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
