require "./coordinate.cr"
require "./tail.cr"

module Snake
  class Player
    module Directions
      Up =    Coordinate.new(0, -1)
      Down =  Coordinate.new(0, 1)
      Left =  Coordinate.new(-1, 0)
      Right = Coordinate.new(1, 0)
    end

    HORIZONTAL_DELAY = 0.01
    VERT_DELAY = HORIZONTAL_DELAY * 3

    DIRECTION_SPEED = {
      Directions::Up => VERT_DELAY,
      Directions::Down => VERT_DELAY,
      Directions::Right => HORIZONTAL_DELAY,
      Directions::Left => HORIZONTAL_DELAY
    }

    property direction : Coordinate
    property head : Coordinate
    property tail : Array(Tail)

    def initialize(x : Int16 = 0, y : Int16 = 0)
      @head = Coordinate.new(x, y)
      @tail = [] of Tail

      @direction = Directions::Up
    end

    def chage_direction(direction)
      return unless can_change?(direction)

      @direction = direction
    end

    def can_change?(direction)
      case {@direction, direction}
      when {Directions::Up, Directions::Down}
      when {Directions::Down, Directions::Up}
      when {Directions::Right, Directions::Left}
      when {Directions::Left, Directions::Right}
        false
      else
        true
      end
    end

    def move : Nil
      prev_head = @head  
      @head = prev_head + @direction

      @tail.push Tail.new(prev_head)
      @tail.shift
    end

    def grow_tail
      @tail.push Tail.new(@head - @direction)
    end

    def x : Int16
      @head.x
    end

    def y : Int16
      @head.y
    end
  end
end
