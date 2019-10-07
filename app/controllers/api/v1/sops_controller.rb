module Api::V1
  class SopsController < ApiController
    def index
      keyword, from, size = sop_search_params
      @search = Sop.search({ keyword: keyword, from: from, size: size }).results.results
      respond_to do |format|
        format.json { render json: @search }
      end
    end

    private

    def sop_search_params
      params.values_at(:searchText, :from, :size)
    end
  end
end
