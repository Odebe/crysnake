require "./interaction.cr"
require "./snake/game.cr"

module Snake
  VERSION = "0.0.1"

  def self.start
    Interaction.start

    world = World.new(width: 80, height: 25)
    player = Player.new(40, 20)
    world.add(player)

    window = Interaction.window(world)
    game = Snake::Game.new(world)

    while game.running?
      sleep Snake::Player::DIRECTION_SPEED[player.direction]
      
      ch = window.get_char
      break if ch == 'q'

      game.tick(player, ch)

      Interaction.draw(window, world)
    end

    Interaction.draw_game_over(
      window,
      player.tail.size
    )
  ensure
    Interaction.stop
  end
end

Snake.start
