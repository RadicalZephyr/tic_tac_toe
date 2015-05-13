module TicTacToe

  class Router
    attr_reader :routes

    def initialize
      @routes = Hash.new({})
    end

    def add_route(path, method, view, &block)
      routes[path] = {:view => view, :block => block}
    end

    def match(env)
      route = routes[env["PATH_INFO"]]
      [200, {}, [route[:view].render(route[:block].call(env))]]
    end

  end

end
