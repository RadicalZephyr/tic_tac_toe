module TicTacToe

  class Mark

    attr_reader :symbol

    def initialize(symbol = " ")
      @symbol = symbol
    end

    def ==(o)
      o.class == self.class && o.symbol == self.symbol
    end

    def hash
      @symbol.hash
    end

    def mark(symbol)
      symbol.kind_of?(String) ? Mark.new(symbol) : symbol
    end

    def blank?
      symbol == " "
    end

    def to_s
      @symbol
    end

  end

  BLANK = TicTacToe::Mark.new

end
