require "matrix"

require "./player.cr"
require "./apple.cr"
require "./world.cr"

module Snake
  class Game
    def initialize(@world : World)
    end

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
      case input
      when NCurses::Key::Up
        player.direction = Player::Directions::Up
      when NCurses::Key::Down
        player.direction = Player::Directions::Down
      when NCurses::Key::Left
        player.direction = Player::Directions::Left
      when NCurses::Key::Right
        player.direction = Player::Directions::Right
      end
    end

    private def check_collisions(player : Player)
      # bounds
      out_of_bounds = player.x < 0 || player.x > @world.width || 
        player.y < 0 || player.y > @world.height
        
      @world.remove(player) if out_of_bounds

      # apples
      eaten_apple = @world.apples.find do |a| 
        a.x == player.x && a.y == player.y
      end

      unless eaten_apple.nil?
        @world.remove(eaten_apple)
        player.grow_tail
      end
    end

    private def generate_apple
      apple = Apple.new(
        Random.rand(1_i16..(@world.width - 1)),
        Random.rand(1_i16..(@world.height - 1))
      )

      @world.add apple
    end

    private def move(player : Player)
      @world.move(player)
    end
  end
end
