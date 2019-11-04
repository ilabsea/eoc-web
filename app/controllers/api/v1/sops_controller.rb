module Api::V1
  class SopsController < ApiController
    def index
      @search = Sop.text_search(sop_params).results.results
      respond_to do |format|
        format.json { render json: @search }
      end
    end

    private

    def sop_params
      params.permit(:q, :page)
    end
  end
end
