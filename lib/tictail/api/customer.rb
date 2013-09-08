module Tictail
  module Api
    module Customer
      def get_customer params
        raise InvalidParams.new('No store id spacified') unless params[:store_id]
        customer_id = params[:customer_id] ? "/#{params[:customer_id]}" : ''
        response = get("/v1/stores/#{params[:store_id]}/customers" + customer_id, params.except(:store_id))
        response.body
      end
    end
  end
end
