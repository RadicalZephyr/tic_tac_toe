module TicTacToe

  class Router

    def add_route(path, method, view, &block)
      puts block.inspect
      @block = block
      @view = view
    end

    def match(env)
      [200, {}, [@view.render(@block.call(env))]]
    end

  end

end
