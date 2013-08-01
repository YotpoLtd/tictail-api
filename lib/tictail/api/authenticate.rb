module Tictail
  module Api
    module Authenticate
      def authenticate(params)
        params[:grant_type] = 'authorization_code'
        response = Faraday.post do |req|
          req.url 'https://tictail.com/oauth/token'
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.body = params.to_param
        end
        if response.status == 200 && response.body
          response_hash = Oj.load(response.body, mode: :compat)
          response_hash
        end
      end
    end
  end
end