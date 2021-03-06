# encoding: utf-8

require 'screen'

module Screens
  class Quit < Screen
    def rendered
      ljust("", Black)+
      ljust("", White)+
      ljust("", White)+
      ljust("", White)+
      center("#{FgBlack}GOOD BYE", White)+
      ljust("", White)*(screen_height-6)+
      ljust("", Black)
    end

    def terminate
      sleep 0.7
      print ResetColor+ResetCursor+ClearScreen
      flush
    end
  end
end
