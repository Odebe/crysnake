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

      tick(player)
    end

    def tick(player : Player, input : Nil)
      tick(player)
    end

    def tick(player : Player, input)
      tick(player)
    end

    def tick(player : Player)
      move(player)
      check_collisions(player)
    end

    # TODO: apple collision
    def check_collisions(player : Player)
      out_of_bounds = player.x < 0 || player.x > @world.width || 
        player.y < 0 || player.y > @world.height
        
      @world.remove(player) if out_of_bounds
    end

    def move(player : Player)
      @world.move(player)
    end
  end
end
