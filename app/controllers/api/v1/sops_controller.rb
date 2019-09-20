module Api::V1
  class SopsController < ApiController
    def index
      @search = Sop.__elasticsearch__.search(params['searchText']).results.results
      respond_to do |format|
        format.json { render json: @search }
      end
    end
  end
end
