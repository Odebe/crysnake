module Snake
  class World
    # getter map : Matrix(Player | Apple | Nil)
    getter map : Array(Array(Player | Apple | Nil))

    getter players : Array(Snake::Player)

    getter width
    getter height

    def initialize(@width : Int16, @height : Int16)
      # @map = Matrix(Player | Apple | Nil).new(@width, @height) { nil }
      @map = Array.new(@height) { Array(Player | Apple | Nil).new(@width) { nil } }

      @players = [] of Snake::Player
      @apples = [] of Snake::Apple
    end

    def to_s
      @map.to_s
    end

    def add(item : Snake::Player)
      @players << item
    end

    def remove(item : Snake::Player)
      @players.delete(item)
    end

    def move(player : Snake::Player)
      @map[player.y][player.x] = nil
      player.move
      @map[player.y][player.x] = player
    end

    def update
    end
  end
end
