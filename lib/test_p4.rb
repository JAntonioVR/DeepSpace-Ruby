#encoding:utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "SpecificDamage"
require_relative "Damage"
require_relative "Hangar"
require_relative "Weapon"
require_relative "GameUniverse"
require_relative "EnemyStarShip"
require_relative "SpaceStation"

module Deepspace
  class TestP4
    def self.main
      weapons=[]
      #weapons.push(Weapon.new("Láser infinito",WeaponType::LASER,100))
      #weapons.push(Weapon.new("Láser ACME",WeaponType::LASER,1))
      weapons.push(Weapon.new("Láser ACME",WeaponType::LASER,1))
      #weapons.push(Weapon.new("Misil ACME",WeaponType::MISSILE,1))
      weapons.push(Weapon.new("Cañón ACME",WeaponType::PLASMA,1)) 
      
      shieldBoosters=[]
      shieldBoosters.push(ShieldBooster.new("El escudo infinito",2.0,100))
      #shieldBoosters.push(ShieldBooster.new("El escudo definitivo",10.0,2))
      shieldBoosters.push(ShieldBooster.new("Escudo ACME",1.5,2))
      
      
      damage=SpecificDamage.new([WeaponType::LASER,WeaponType::MISSILE,WeaponType::MISSILE,WeaponType::MISSILE,WeaponType::PLASMA],4)
      
      puts damage.to_s
      damage=damage.adjust(weapons, shieldBoosters)
      puts damage.to_s
      
      #damage1=damage1.adjust(weapons, shieldBoosters)
      #puts damage2.to_s
      
    end
    
    
    
  end
  
TestP4.main  
 
end
