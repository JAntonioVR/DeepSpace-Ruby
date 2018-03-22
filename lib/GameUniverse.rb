
require_relative "GameUniverseToUI"
require_relative "GameStateController"
require_relative "Dice"
require_relative "CombatResult"
require_relative "GameCharacter"
require_relative "ShotResult"
require_relative "SpaceStation"
require_relative "CardDealer"

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
      @spaceStations=[]
      @currentEnemy=nil
    end
    
    def combat
      
    end
    
    def combat(station, enemy)
      
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
      return GameUniverseToUI.new(self)
    end
    
    def haveAWinner
      return @currentStation.nMedals>=@@WIN
    end
    
    def init(names)
      
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
      
    end
    
    def to_s
      return "\nEstacion que tiene el turno: "+@currentStation.to_s+
        "\nResto de estaciones: "+@spaceStations.to_s+"\nEnemigo: "+@currentEnemy.to_s+"Estado: "+gameState.state.to_s+
        "\Numero de turnos: "+@turns
    end
    
  end

end
