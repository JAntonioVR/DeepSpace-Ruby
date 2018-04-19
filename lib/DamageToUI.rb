
module Deepspace

# 2.3.17 - Translation from Java
# @author Profesor
    
class DamageToUI
  
  attr_reader :nWeapons, :weapons, :nShields
  
  def initialize (d) 
    @nWeapons=d.nWeapons
    @nShields=d.nShields
    tmp=d.weapons
    if (tmp!=nil) then
      @weapons=Array.new(tmp)
    else
      @weapons=nil
    end
  end
    
  public
  
  def getWeaponInfo() 
    cad = "";
    
    if (nWeapons == -1) then
      @weapons.each { |tipo|
          if(tipo==WeaponType::MISSILE)
            cad=cad+"MISSILE  "
          elsif(tipo==WeaponType::PLASMA)
            cad=cad+"PLASMA  "
          else
            cad=cad+"LASER  "
          end
        }
    else
      cad += @nWeapons.to_s
    end
    return cad
  end
    
  def to_s
    out = "Weapons: " + getWeaponInfo() + ", Shields: #{@nShields}"
  end
  
end # class

end # module
