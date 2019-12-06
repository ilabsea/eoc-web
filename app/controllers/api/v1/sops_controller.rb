# frozen_string_literal: true

module Api::V1
  class SopsController < ApiController
    def index
      @search = SearchService.text_search(sop_params)
      render json: @search.as_json(methods: [:model_name])
    end

    def show
      @sop = Sop.find_by(id: params[:id])
      render json: @sop
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
