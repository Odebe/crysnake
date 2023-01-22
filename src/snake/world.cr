module Snake
  class World
    # getter map : Matrix(Player | Apple | Nil)
    getter map : Array(Array(Player | Player::Tail | Apple | Nil))

    getter players : Array(Snake::Player)
    getter apples : Array(Snake::Apple)

    getter width
    getter height

    def initialize(@width : Int16, @height : Int16)
      # @map = Matrix(Player | Apple | Nil).new(@width, @height) { nil }
      @map = Array.new(@height) { Array(Player | Apple | Player::Tail | Nil).new(@width) { nil } }

      @players = [] of Snake::Player
      @apples = [] of Snake::Apple
    end

    def to_s
      @map.to_s
    end

    def add(item : Snake::Player)
      @players << item
    end

    def add(item : Snake::Apple)
      @apples << item
    end

    def remove(item : Snake::Player)
      @players.delete(item)
    end

    def remove(item : Snake::Apple)
      @apples.delete(item)
    end

    def move(player : Snake::Player)
      @map[player.y][player.x] = nil

      if player.tail.any?
        tail = player.tail.first
        @map[tail.y][tail.x] = nil
      end

      player.move
    end

    def update
      @players.each do |player|
        @map[player.y][player.x] = player

        player.tail.each do |tail|
          @map[tail.y][tail.x] = tail
        end
      end

      @apples.each do |apple|
        @map[apple.y][apple.x] = apple
      end
    end
  end
end
