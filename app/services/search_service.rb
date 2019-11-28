# frozen_string_literal: true

class SearchService
  def self.text_search(params)
    option = {
      fields: ["name", "tags", "description"],
      page: params[:page],
      per_page: params[:per_page] || 10,
      models: [Sop, Category],
      match: :word_middle
    }

    Searchkick.search(params[:q], option)
  end
end
