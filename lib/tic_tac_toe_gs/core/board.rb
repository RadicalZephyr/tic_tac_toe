require "tic_tac_toe_gs/core/mark"

module TicTacToeGS
  module Core

    class Board
      include Enumerable

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
        TicTacToeGS::Core::Board.new(marks.map { |m| TicTacToeGS::Core::BLANK.mark(m) }.to_a)
      end

      def self.empty_board
        board = TicTacToeGS::Core::Board.new([])
        board.reset
      end

      def initialize(marks)
        @marks = marks
      end

      def each(&block)
        @marks.each do |m|
          block.call(m)
        end
      end

      def reset
        @marks = Array.new(9, TicTacToeGS::Core::Mark.new)
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
        @marks[index] = @marks[index].mark(mark)
      end

      def speculative_move(mark, index)
        board = TicTacToeGS::Core::Board.from(Array.new(@marks))
        board.move(mark, index)
        return board
      end

      def legal?(index)
        @marks[index].blank?
      end

      def full?
        @marks.none? { |m| m.blank? }
      end

      def attack_sets
        WIN_PLACES.map { |places| places.map { |n| @marks.at n }}
      end

      IndexedCell = Struct.new(:index, :mark)

      def indexed_attack_sets
        WIN_PLACES.map { |places| places.map { |n| IndexedCell.new(n, @marks.at(n)) }}
      end

      def empty_spaces
        @marks.map.with_index { |mark, index| index if mark.blank? }.compact
      end
    end

  end
end
