class SearchesController < ApplicationController
  include Pagy::Backend

  def index
    @results = SearchService.text_search(params.merge(items: 20))
    @pagy = Pagy.new_from_elasticsearch_rails(@results)
  end
end

