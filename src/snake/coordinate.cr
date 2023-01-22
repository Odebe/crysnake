module Snake
  class Coordinate
    getter x, y
    
    def initialize(@x : Int16, @y : Int16)
    end

    def ==(other : Coordinate)
      @x == other.x && @y == other.y
    end

    def +(other)
      Coordinate.new(@x + other.x, @y + other.y)
    end

    def -(other)
      Coordinate.new(@x - other.x, @y - other.y)
    end
  end
end
