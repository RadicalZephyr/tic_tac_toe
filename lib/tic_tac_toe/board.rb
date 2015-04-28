module TicTacToe

  class Board
    WIN_PLACES = [[0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8],
                  [0, 3, 6],
                  [1, 4, 7],
                  [2, 5, 8],
                  [0, 4, 8],
                  [2, 4, 6]]

    def self.win_places
      WIN_PLACES
    end

    def self.empty_board
      board = TicTacToe::Board.new
      board.reset
    end

    def reset
      @marks = Array.new(9, " ")
      return self
    end

    def board_to_string
      rows = @marks.each_slice(3)
      row_strings = rows.map { |row| Array(row).join(" | ") }
      row_strings.join("\n--+---+--\n")
    end

    def pos index
      @marks[index]
    end

    def move(mark, index)
      @marks[index] = mark
    end

    def legal? index
      @marks[index] == " "
    end

    def full?
      @marks.none? { |m| m == " " }
    end

    def attack_sets
      WIN_PLACES.map { |places| places.map { |n| @marks.at n }}
    end

  end

end
