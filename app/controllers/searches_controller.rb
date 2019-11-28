# frozen_string_literal: true

class SearchesController < ApplicationController
  include Pagy::Backend

  def index
    @results = SearchService.text_search(params.merge(per_page: 20))
    @pagy = Pagy.new_from_searchkick(@results)
  end
end
