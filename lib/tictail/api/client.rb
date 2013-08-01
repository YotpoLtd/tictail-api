require 'faraday'
require 'faraday_middleware'
require 'tictail/faraday_middleware/response_parser'
require 'tictail/faraday_middleware/encode_oj'
require 'tictail/faraday_middleware/parse_oj'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

require 'tictail/api/authenticate'
require 'tictail/api/ping'
require 'tictail/helper'



module Tictail
  class Client
    include Tictail::Helper
    include Tictail::Api::Authenticate
    include Tictail::Api::Ping

    attr_accessor :access_token

    #
    # Creates a new instance of Tictail::Api::Client
    #
    # @param url [String] The url to Tictail api (https://api.tictail.com)
    def initialize(url = 'https://api.tictail.com')
      @url = url
    end


    #
    # Does a GET request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    # @param params [Hash] the url params that should be passed in the request
    def get(url, params = {})
      params = params.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo}
      @access_token = params.delete('access_token') if params['access_token']
      return connection.get(url, params)
    end

    #
    # Does a POST request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    # @param params [Hash] the body of the request
    def post(url, params)
      params = convert_hash_keys(params)
      @access_token = params.delete('access_token') if params['access_token']
      return connection.post(url, params)
    end

    #
    # Does a PUT request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    # @param params [Hash] the body of the request
    def put(url, params)
      params = convert_hash_keys(params)
      @access_token = params.delete('access_token') if params['access_token']
      return connection.put(url, params)
    end

    #
    # Does a DELETE request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    def delete(url, params)
      params = convert_hash_keys(params)
      @access_token = params.delete('access_token') if params['access_token']
      return connection.delete(url)
    end
    private

    def connection
      header = {:tictail_api_connector => 'Ruby-'+ Tictail::Api::VERSION, 'Content-Type' => 'application/json' }
      header.merge!({:Authorization => 'Bearer ' + access_token}) unless access_token.nil?
      @connection ||= Faraday.new(url: @url, headers: header, ssl: {verify: true}) do |conn|

        conn.use Tictail::ResponseParser

        # Setting response parser to oj
        conn.request :oj
        conn.response :oj, :content_type => /\bjson$/

        conn.adapter :typhoeus
      end
    end
  end
end