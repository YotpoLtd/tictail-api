module Tictail
  module Api
    module Register
      def register(params)
        params = symbolize_keys!(params)
        raise Exception.new 'Invalid Params' unless params[:code] || params[:client_id] || params[:client_secret]
        params.merge!(:grant_type => 'authorization_code')
        response = Faraday.post do |req|
          req.url 'https://tictail.com/oauth/token'
          req.headers['Content-Type'] = 'application/json'
          req.body = params.to_json
        end
        a=0;
        a+=1
      end
    end
  end
end