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
    w.timeout = 100
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

  def self.draw_game_over(window, count)
    window.print "GAME OVER", [10, 10]
    window.print "Eaten: #{count}", [12, 10]
    window.print "Press Q to quit", [18, 10]

    window.refresh
    window.no_timeout

    loop do 
      ch = window.get_char
      break if ch == 'q'
    end

  end

  def self.draw(window, world : Snake::World)
    window.clear
    window.box '#', '#'

    map = world.map 
    
    world.height.times do |y|
      world.width.times do |x|
        item = map[y][x]

        if item.is_a? Snake::Player
          window.print "O", [y, x]
        end

        if item.is_a? Snake::Tail
          window.print "*", [y, x]
        end

        if item.is_a? Snake::Apple
          window.print "6", [y, x]
        end
      end
    end

    window.refresh
  end
end
