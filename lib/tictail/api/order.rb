module Tictail
  module Api
    module Order
      def get_orders params
        raise InvalidParams.new('No store id spacified') unless params[:store_id]
        order_id = params[:order_id] ? "/#{params[:order_id]}" : ''
        response = get("/v1/stores/#{params[:store_id]}/orders" + order_id, params.except(:store_id))
        response.body
      end
    end
  end
end