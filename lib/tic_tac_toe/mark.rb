module TicTacToe

  class Mark
    attr_reader :symbol

    def initialize(symbol = " ")
      @symbol = symbol
    end

    def ==(o)
      o.class == self.class && o.symbol == self.symbol
    end

    def mark(symbol)
      Mark.new(symbol)
    end

    def blank?
      symbol == " "
    end

    def to_s
      @symbol
    end

  end

end
