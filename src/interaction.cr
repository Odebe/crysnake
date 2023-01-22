require "ncurses"

module Interaction
  def self.start
    NCurses.start
    NCurses.cbreak
    NCurses.no_echo
    NCurses.keypad true
    NCurses.set_cursor(visibility: NCurses::Cursor::Invisible)
  end

  def self.window(world)
    w = NCurses::Window.new(world.height, world.width, 0, 0)
    w.timeout = 60
    w.keypad true
    w.box '#', '#'
    w
  end

  def self.stop
    NCurses.end
  end

  def self.get_char
    NCurses.get_char
  end

  def self.draw(window, world : Snake::World)
    window.clear
    window.box '#', '#'

    map = world.map 
    
    world.height.times do |y|
      world.width.times do |x|
        item = map[y][x]

        unless item.nil?
          window.print "O", [y, x]
        end
      end
    end

    window.refresh
  end
end
