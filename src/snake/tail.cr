require "./coordinate.cr"

module Snake
  class Tail
    getter coord : Coordinate

    def initialize(@coord : Coordinate)
    end
  end
end
