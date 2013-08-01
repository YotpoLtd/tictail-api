module Tictail
  module Api
    module Ping
      def ping params
        return get('/v1/teapot', params)
      end
    end
  end
end
