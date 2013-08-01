module Tictail
  class ResponseParser < Faraday::Response::Middleware
    def call(env)
      # "env" contains the request
      @app.call(env).on_complete do
        if env[:status] == 401 || env[:status] == 403
          raise HTTPUnauthorized.new 'invalid storeenvy credentials'
        end
      end
    end
    class HTTPUnauthorized < Exception
    end
  end
end