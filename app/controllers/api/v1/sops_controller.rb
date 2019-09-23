module Api::V1
  class SopsController < ApiController
    def index
      @search = Sop.search({keyword: params['searchText'], from: params['from'], size: params['size']}).results.results
      respond_to do |format|
        format.json { render json: @search }
      end
    end
  end
end
