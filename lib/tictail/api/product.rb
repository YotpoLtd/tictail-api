module Tictail
  module Api
    module Product
      def get_products params
        raise InvalidParams.new('No store id spacified') unless params[:store_id]
        response = get("/v1/stores/#{params[:store_id]}/products", params)
        response.body
      end
    end
  end
end
