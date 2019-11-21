# frozen_string_literal: true

module Api::V1
  class SopsController < ApiController
    def index
      @search = SearchService.text_search(sop_params)
      if token == ENV["SERVER_SECRET_KEY_BASE"]
        render json: @search
      else
        render json: { 
          error: "Unauthorize request",
          status: :bad_request }
      end
    end

    private
      def sop_params
        params.permit(:q, :page)
      end

      def token
        @token ||= request.headers["Authorization"].split.last
      end
  end
end
