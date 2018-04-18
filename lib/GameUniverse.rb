
require_relative "GameUniverseToUI"
require_relative "GameStateController"
require_relative "Dice"
require_relative "CombatResult"
require_relative "GameCharacter"
require_relative "ShotResult"
require_relative "SpaceStation"
require_relative "CardDealer"
require_relative "EnemyStarShip"

module Deepspace
  
  class GameUniverse
    @@WIN=10
    
    attr_reader :gameState
    
    public
    
    def initialize
      @turns=0
      @gameState=GameStateController.new
      @currentStationIndex=-1
      @dice=Dice.new
      @currentStation=nil
      @spaceStations=Array.new
      @currentEnemy=nil
    end
    
    def combat
      state=@gameState.state
      if(state==GameState::BEFORECOMBAT || state==GameState::INIT)
        return combatGo(@currentStation,@currentEnemy)
      else
        return CombatResult::NOCOMBAT
      end
    end
    
    def combatGo(station, enemy)
      ch=@dice.firstShot
      if(ch==GameCharacter::ENEMYSTARSHIP)
          fire=@currentEnemy.fire
          result=@currentStation.receiveShot(fire)
            if(result==ShotResult::RESIST)
              fire=@currentStation.fire
              result=@currenEnemy.receiveShot(fire)
              enemyWins=(result==ShotResult::RESIST)
            else
              enemyWins=true
            end
      else
          fire=@currentStation.fire
          result=@currentEnemy.receiveShot(fire)
          enemyWins=(result==ShotResult::RESIST)
      end
      if enemyWins
        s=@currentStation.getSpeed
        moves=@dice.spaceStationMoves(s)
        if(!moves)
          damage=@currentEnemy.damage
          @currentStation.setPendingDamage(damage)
          combatResult=CombatResult::ENEMYWINS
        else
          @currentStation.move
          combatResult=CombatResult::STATIONESCAPES
        end
      else
        aLoot=@currentEnemy.loot
        @currentStation.setLoot(aLoot)
        combatResult=CombatResult::STATIONWINS
      end
      @gameState.next(@turns, @spaceStations.length)
      return combatResult
    end
   
    def discardHangar
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.discardHangar
      end
      
    end
    
    def discardShieldBooster(i)
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.discardShieldBooster(i)
      end
    end
    
    def discardShieldBoosterInHangar(i)
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.discardShieldBoosterInHangar(i)
      end
    end
    
    def discardWeapon(i)
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.discardWeapon(i)
      end
    end
    
    def discardWeaponInHangar(i)
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.discardWeaponInHangar
      end
    end
    
    def getUIversion
      return GameUniverseToUI.new(@currentStation,@currentEnemy)
    end
    
    def haveAWinner
      return @currentStation.nMedals>=@@WIN
    end
    
    def init(names)
      state=@gameState.state
      if(state==GameState::CANNOTPLAY)
        dealer=CardDealer.instance
        for i in 0..(names.length-1)
          supplies=dealer.nextSuppliesPackage
          station=SpaceStation.new(names[i],supplies)
          nh=@dice.initWithNHangars
          nw=@dice.initWithNWeapons
          ns=@dice.initWithNShield
          l=Loot.new(0,nw,ns,nh,0)
          station.setLoot(l)
          @spaceStations.push(station)
        end
        @currentStationIndex=@dice.whoStarts(names.length)
        @currentStation=@spaceStations[@currentStationIndex]
        @currentEnemy=dealer.nextEnemy
        @gameState.next(@turns,names.length)
      end
    end
    
    def mountShieldBooster(i)
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.mountShieldBooster(i)
      end
    end
    
    def mountWeapon(i)
      if @gameState.state==GameState::INIT || @gameState.state==GameState::AFTERCOMBAT
        @currentStation.mountWeapon(i)
      end
    end
    
    def nextTurn
      state=@gameState.state
      if(state==GameState::AFTERCOMBAT)
        stationState=@currentStation.validState
        if(stationState)
          @currentStation=@spaceStations[(@currentStationIndex+1)%@spaceStations.length]
          @currentStation.cleanUpMountedItems
          dealer=CardDealer.instance
          @currentEnemy=dealer.nextEnemy
          @gameState.next(@turns, @spaceStations.length)
          return true
        end
        return false
      end
      return false
    end
    
    def state
      return @gameState.state
    end
    
    def to_s
      cad="\nEstacion que tiene el turno: "+@currentStation.to_s+"\n\nResto de estaciones:"
      @spaceStations.each{ |estacion|
        cad+=estacion.to_s if estacion!=@currentStation
      }
      cad+="\n\nEnemigo: "+@currentEnemy.to_s+"Estado: "+@gameState.state.to_s+"\nNumero de turnos:+#{@turns}."
      return cad
    end
    
  end

end
