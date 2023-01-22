require "./player.cr"
require "./apple.cr"
require "./world.cr"
require "./coordinate.cr"

module Snake
  class Game
    def initialize(@world : World)
    end

    DIRECTION_MAPPRINGS = {
      NCurses::Key::Up => Player::Directions::Up,
      NCurses::Key::Down => Player::Directions::Down,
      NCurses::Key::Right => Player::Directions::Right,
      NCurses::Key::Left => Player::Directions::Left
    }

    def running?
      @world.players.any?
    end

    def tick(player : Player, input : NCurses::Key)
      update_direction(player, input)
      tick(player)
    end

    def tick(player : Player, input)
      tick(player)
    end

    def tick(player : Player)
      move(player)
      check_collisions(player)
      generate_apple if @world.apples.none?

      @world.update
    end

    private def update_direction(player : Player, input)
      direction = DIRECTION_MAPPRINGS[input]?
      return unless direction

      player.chage_direction(direction)
    end

    private def check_collisions(player : Player)
      @world.remove(player) if check_out_of_bounds(player) || check_bite_own_tail(player)

      if apple = check_eaten_apple(player)
        player.grow_tail
        @world.remove(apple)
      end
    end

    private def check_out_of_bounds(player) : Bool
      player.x < 0 || player.x >= (@world.width  - 1) || 
      player.y < 0 || player.y >= (@world.height - 1)
    end

    private def check_bite_own_tail(player) : Bool
      player.tail.any? do |tail|
        player.head == tail.coord
      end
    end

    private def check_eaten_apple(player) : Apple?
      @world.apples.find do |apple| 
        apple.coord == player.head
      end
    end

    private def generate_apple
      coord = Coordinate.new(
        Random.rand(2_i16..(@world.width - 2)),
        Random.rand(2_i16..(@world.height - 2))
      )

      @world.add(Apple.new(coord))
    end

    private def move(player : Player)
      @world.move(player)
    end
  end
end
