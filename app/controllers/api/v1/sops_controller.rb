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
        if token != ENV["SERVER_SECRET_KEY_BASE"]
          render json: { error: "Unauthorize request", status: :bad_request }
        end
      end
  end
end
