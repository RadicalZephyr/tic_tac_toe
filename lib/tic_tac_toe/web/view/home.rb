require 'mustache'

module TicTacToe
  module View

    class Home < Mustache

      def self.render(_)
        self.new.render
      end

      def players
        base_player = {:types => [{:type => "human", :type_value => "h"},
                                  {:type => "ai", :type_value => "a"},
                                  {:type => "random", :type_value => "r"}]}
        [{:index => 1}.merge(base_player),
         {:index => 2}.merge(base_player)]
      end
    end

  end
end
