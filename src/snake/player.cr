module Snake
  class Player
    module Directions
      Up = Matrix.rows([[0_i16, -1_i16]])
      Down = Matrix.rows([[0_i16, 1_i16]])
      Left = Matrix.rows([[-1_i16, 0_i16]])
      Right = Matrix.rows([[1_i16, 0_i16]])
    end

    property direction : Matrix(Int16)
    property head : Matrix(Int16)
    property tail : Array(Tail)

    class Tail
      def initialize(@cord : Matrix(Int16))
      end

      def x : Int16
        @cord[0, 0]
      end
  
      def y : Int16
        @cord[0, 1]
      end
    end

    def initialize(x : Int16 = 0, y : Int16 = 0)
      @head = Matrix.rows([[x, y]])
      @tail = [] of Tail

      @direction = Directions::Up
    end

    def move : Nil
      prev_head = @head  
      @head = prev_head + @direction

      @tail.push Tail.new(prev_head)
      @tail.shift
    end

    def grow_tail
      @tail.push Tail.new(@head)
    end

    def x : Int16
      @head[0, 0]
    end

    def y : Int16
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
