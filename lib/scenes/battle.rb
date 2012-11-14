# encoding: utf-8

require 'scene'

module Scenes
  class Battle < Scene

    def initialize(game, map)
      super(game)
      @map        = map
      @retreated  = false
      pick_enemy
      @screen = Screens::Battle.new(@game.hero, @enemy)
      flush_input
    end

    def run
      super
      if @retreated
        restaff_enemy
      elsif @enemy.alive?
        @screen.report "#{@enemy.name} you died. Game over. Press space to continue."
      else
        @screen.report "#{@enemy.name} died. Congratulations, you win! Press space to continue."
      end
      @screen.draw
      get_space
    end

    def main
      @screen.draw
      expect_input 'a' => :attack,
                   'r' => :retreat,
                   'b' => :block,
                   'i' => :use_item,
                   'q' => :exit

      @exit = @exit || @game.hero.dead? || @enemy.dead?
      unless @retreated || @enemy.dead?
        @screen.draw
        sleep 0.5
        damage_dealt = @game.hero.take_physical_damage @enemy.attack
        @screen.report "#{@enemy.name} attacks you and deals #{damage_dealt}"
      end
    end

    def attack
      damage_dealt = @enemy.take_physical_damage @game.hero.attack
      @screen.report "You attack #{@enemy.name} and deal #{damage_dealt}"
    end

    def retreat
      if rand < 0.35
        @screen.report "You successfully retreated"
        @retreated = true
      else
        @screen.report "You tried to retreat, but failed"
      end
    end

    def pick_enemy
      enemy_name  = @map.enemies.keys.sample
      @enemy      = Enemies[enemy_name].dup
      @map.enemies[@enemy.name] -= 1
      @map.enemies.delete(@enemy.name) if @map.enemies[@enemy.name] == 0
    end

    def restaff_enemy
      if Enemies[@enemy.name]
        Enemies[@enemy.name] += 1
      else
        Enemies[@enemy.name] = 1
      end
    end
  end
end

__END__
  @screen.report "You have initiative"