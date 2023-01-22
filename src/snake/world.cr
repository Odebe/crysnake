module Snake
  class World
    getter map : Array(Array(Player | Tail | Apple | Nil))

    getter players : Array(Snake::Player)
    getter apples : Array(Snake::Apple)

    getter width
    getter height

    def initialize(@width : Int16, @height : Int16)
      @map = Array.new(@height) { Array(Player | Apple | Tail | Nil).new(@width) { nil } }

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

    def remove(player : Snake::Player)
      @players.delete(player)

      @map[player.head.y][player.head.x] = nil
      player.tail.each do |tail|
        @map[tail.coord.y][tail.coord.x] = tail
      end
    end

    def remove(apple : Snake::Apple)
      @apples.delete(apple)
      @map[apple.coord.y][apple.coord.x] = nil
    end

    def move(player : Snake::Player)
      @map[player.head.y][player.head.x] = nil

      if player.tail.any?
        tail = player.tail.first
        @map[tail.coord.y][tail.coord.x] = nil
      end

      player.move
    end

    def update
      @players.each do |player|
        @map[player.head.y][player.head.x] = player

        player.tail.each do |tail|
          @map[tail.coord.y][tail.coord.x] = tail
        end
      end

      @apples.each do |apple|
        @map[apple.coord.y][apple.coord.x] = apple
      end
    end
  end
end
