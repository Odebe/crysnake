require "./coordinate.cr"

module Snake
  class Apple
    getter coord : Coordinate

    def initialize(@coord : Coordinate)
    end
  end
end
