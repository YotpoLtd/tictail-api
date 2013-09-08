module Tictail
  module Api
    module Card
      def post_card params
        raise InvalidParams.new('No store id spacified') unless params[:store_id]
        response = post("/v1/stores/#{params[:store_id]}/cards" , params.except(:store_id))
        response.body
      end
    end
  end
end
