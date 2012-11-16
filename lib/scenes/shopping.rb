# encoding: utf-8

require 'scene'
require 'scenes'
  
module Scenes
  class Shopping < Scene
    
    def initialize(shop)
      @shop        = shop
      @@cursorline = 41
      @screen = Screens::Shop.new(nil, (ShopItem = Struct.new(:type, :name, :quantity, :price, :desc); items = [ShopItem.new('Use', 'Apple', 20, 5, 'A pretty green apple'), ShopItem.new('Helmet', 'Wool Cap', 1, 200, 'This is desc of wool cap')])  )
    end
    
    def main
      @screen.draw
      expect_input 'w' => :move_up,
                   'a' => :move_up,
                   's' => :move_down,
                   'd' => :move_down,
                   ' ' => :choose,
                   'q' => :quit
    end
    
    def move_up
      
      if @@cursorline > 0 
        @@cursorline -= 1
        @shop.draw
      else beep
      end
      
    end
    
    def move_down
      if @@cursorline < 40
      @@cursorline += 1
      @shop.draw
      else beep
      end
    end  
  end

end
               
    
      
