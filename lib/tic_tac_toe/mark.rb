module TicTacToe

  class Mark

    def initialize(symbol = " ")
      @symbol = symbol
    end

    def mark(symbol)
      Mark.new(symbol)
    end

    def symbol
      @symbol
    end

    def blank?
      true
    end

  end

end
