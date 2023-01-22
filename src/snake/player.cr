module Snake
  class Player
    module Directions
      Up = Matrix.rows([[0_i16, -1_i16]])
      Down = Matrix.rows([[0_i16, 1_i16]])
      Left = Matrix.rows([[-2_i16, 0_i16]])
      Right = Matrix.rows([[2_i16, 0_i16]])
    end

    property direction : Matrix(Int16)
    property head : Matrix(Int16)
    property tail : Array(Matrix(Int16))

    def initialize(x : Int16 = 0, y : Int16 = 0)
      @head = Matrix.rows([[x, y]])
      @tail = [] of Matrix(Int16)

      @direction = Directions::Up
    end

    def move : Nil
      prev_head = @head  
      @head = prev_head + @direction

      @tail.push prev_head
      @tail.shift
    end

    def x
      @head[0, 0]
    end

    def y
      @head[0, 1]
    end

    def to_s 
      "#{@head}, tail: #{@tail}"
    end

    def alive?
      true
    end
  end
end
