module TicTacToe

  class Router
    attr_reader :routes

    def initialize
      @routes = {}
    end

    def add_route(path, method, view, &block)
      routes[{:path => path,
              :method => method.to_s}] = {:view => view, :block => block}
    end

    def match(env)
      route = routes[{:path => env["PATH_INFO"],
                      :method => env["REQUEST_METHOD"]}]
      [200, {}, [route[:view].render(route[:block].call(env))]]
    end

  end

end
