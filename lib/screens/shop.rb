# encoding: utf-8

require 'screen'

module Screens
  class Shop < Screen
    attr_accessor :cursor, :hero

    Row = "\e[38;5;#{Black};48;5;%dm%5sx %-14s %-24s %5d$"

    def initialize(hero, shop)
      @hero       = hero
      @shop       = shop
      @items      = shop.items
      @cursor     = 0
      @max_items  = 36
    end

    def highlighted_item
      @items[@cursor]
    end

    # returns whether the cursor can be moved down
    def move_down?
      @cursor+1 < @items.length
    end

    # returns whether the cursor can be moved up
    def move_up?
      @cursor > 0
    end

    def move_down
      @cursor += 1
    end

    def move_up
      @cursor -= 1
    end

    def rendered
      buffer hero_stats(@hero)
      @items.each_with_index do |item, index|
        buffer ljust(Row % [row_color(index), item.quantity, item.type, item.name, item.price], row_color(index))
      end
      @items.size.upto(@max_items-1) do | index |
        buffer ljust("" , row_color(index))
      end
      buffer box(@items[@cursor].description, padding: 1, height: 2, background: 220)
      buffer help
    end

    def help
      key_map_help(
        'WASD'  => 'Change Selection',
        'Space' => 'Choose',
        'Q'     => 'Exit'
      )
    end

  private
    def row_color(index)
      if index == @cursor
        87
      elsif index.even?
        253
      else
        White
      end
    end
  end
end
