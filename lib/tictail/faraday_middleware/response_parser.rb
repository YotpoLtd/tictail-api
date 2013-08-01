module Tictail
  class ResponseParser < Faraday::Response::Middleware
    def call(env)
      # "env" contains the request
      @app.call(env).on_complete do
        body = false
        if env[:status] == 200
          body = env[:response].body.response.first[1]
        elsif env[:status] == 401 || env[:status] == 403
          raise HTTPUnauthorized.new 'invalid storeenvy credentials'
        elsif env[:response] && env[:response].respond_to?(:body) && env[:response].body.respond_to?(:status)
          body = env[:response].body.status
        end
        env[:body] = body
      end
    end

    class HTTPUnauthorized < Exception
    end
  end
end