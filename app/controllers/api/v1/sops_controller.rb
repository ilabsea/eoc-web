# frozen_string_literal: true

module Api::V1
  class SopsController < ApiController
    before_action :check_secret_key

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
        auth = request.headers["Authorization"]
        @token ||= auth.split.last if auth
      end

      def check_secret_key
        if token != Rails.application.credentials.app[:server_secret_key_base]
          render json: { error: t(:unauthorize), status: :bad_request }
        end
      end
  end
end
