require 'faraday'
require 'faraday_middleware'
require 'tictail/api/register'
require 'tictail/helper'


module Tictail
  class Client
    include Tictail::Helper
    include Tictail::Api::Register

    attr_accessor :access_token

    #
    # Creates a new instance of Tictail::Api::Client
    #
    # @param url [String] The url to Storenvy api (https://api.storenvy.com)
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
      params.merge!(:access_token => access_token)  if access_token
      return connection.get(url, params)
    end

    #
    # Does a POST request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    # @param params [Hash] the body of the request
    def post(url, params)
      params = convert_hash_keys(params)
      params.merge!(:access_token => access_token)  if access_token
      return connection.post(url, params)
    end

    #
    # Does a PUT request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    # @param params [Hash] the body of the request
    def put(url, params)
      params = convert_hash_keys(params)
      params.merge!(:access_token => access_token)  if access_token
      return connection.put(url, params)
    end

    #
    # Does a DELETE request to the url with the params
    #
    # @param url [String] the relative path in the Tictail API
    def delete(url, params)
      params = convert_hash_keys(params)
      params.merge!(:access_token => access_token)  if access_token
      return connection.delete(url)
    end
    private

    def connection
      header = access_token.nil? ? {:tictail_api_connector => 'Ruby'+ Tictail::Api::VERSION } : {:tictail_api_connector => 'Ruby'+ Tictail::Api::VERSION, :Authorization => 'Bearer ' + access_token}
      @connection ||= Faraday.new(url: @url, headers: header) do |conn|

        # Setting request and response to use JSON/XML
        conn.request :oj
        conn.response :oj
      end
    end
  end
end