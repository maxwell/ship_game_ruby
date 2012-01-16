#kludge ruby 1.9.2 introduced
$: << "."

require 'rubygems'
require 'gosu'

require 'coors.rb'
require 'ship.rb'
require 'ship_builder.rb'
require 'debug_string'

class GameWindow < Gosu::Window
  
  def initialize
    super(1200,700,false,16.66667)
    self.caption = "Update/Draw Demo"
    
    # we load the font once during initialize, much faster than
    # loading the font before every draw
    @font = Gosu::Font.new(self,Gosu::default_font_name,20)
    @counter = 0
    @debug_strings =DebugStrings.new
    @image1 = Gosu::Image.new(self,"media/testShip2.bmp",false)
    @image2 = Gosu::Image.new(self,"media/testShip3.bmp",false)
    @builder = ShipBuilder.new self
    @ships = {}
    
    @ships[:player] = @builder.new_ship_player
    @ships[:test_2] = @builder.new_ship @image2
    #require 'ruby-debug';debugger
    
    @this_frame =50
    @last_frame =50
    @delta = 0.0
  end
  
  def update
    calculate_delta
    @counter += 1
    @ships.each {|key,ship|ship.update @delta;}
    
  end
  
  def needs_redraw
    false
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = (@this_frame - @last_frame)/1000.0
    @last_frame = @this_frame
  end
  
  def draw
    #@font.draw(@counter,0,0,1)
    
    @ships.each {|k,s|s.draw }
 
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close # exit on press of escape key
    
    end
    
    if id == Gosu::KbQ
     @ships[:player].loc.set(400,400)
    end 
  end
  
end

window = GameWindow.new
window.show

