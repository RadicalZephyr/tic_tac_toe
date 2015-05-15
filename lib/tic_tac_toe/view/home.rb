require 'mustache'

module TicTacToe
  module View

    class Home < Mustache

      def self.render(_)
        self.new.render
      end

    end

  end
end
