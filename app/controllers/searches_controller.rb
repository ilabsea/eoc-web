# frozen_string_literal: true

class SearchesController < ApplicationController
  include Pagy::Backend

  def index
    @results = SearchService.text_search(search_params)
    @pagy = Pagy.new_from_searchkick(@results)
  end

  private
    def search_params
      data = params.merge(per_page: 20)
      data[:q] = "*" unless data[:q].present?
      data
    end
end
