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

    def self.from(marks)
      board = TicTacToe::Board.new(marks)
    end

    def self.empty_board
      board = TicTacToe::Board.new([])
      board.reset
    end

    def initialize(marks)
      @marks = marks
    end

    def reset
      @marks = Array.new(9, " ")
      return self
    end

    def to_s
      rows = @marks.each_slice(3)
      row_strings = rows.map { |row| Array(row).join(" | ") }
      row_strings.join("\n--+---+--\n")
    end

    def pos(index)
      @marks[index]
    end

    def move(mark, index)
      @marks[index] = mark
    end

    def speculative_move(mark, index)
      board = TicTacToe::Board.from(Array.new(@marks))
      board.move(mark, index)
      return board
    end

    def legal?(index)
      @marks[index] == " "
    end

    def full?
      @marks.none? { |m| m == " " }
    end

    def attack_sets
      WIN_PLACES.map { |places| places.map { |n| @marks.at n }}
    end

    IndexedCell = Struct.new(:index, :mark)

    def indexed_attack_sets
      WIN_PLACES.map { |places| places.map { |n| IndexedCell.new(n, @marks.at(n)) }}
    end

    def empty_spaces
      @marks.map.with_index { |mark, index| index if mark == " " }.compact
    end
  end

end
