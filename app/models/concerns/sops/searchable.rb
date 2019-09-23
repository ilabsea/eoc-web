require 'elasticsearch/model'

module Sops::Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.search(params)
      return self.__elasticsearch__.search({query: {match_all: {}}, size: 20}) if params[:keyword].blank?

      highlight_options = {
        fragment_size: 180,
        number_of_fragments: 2,
      }
      highlight = {
        pre_tags: ["<em class='highlight'>"],
        post_tags: ["</em>"],
        fields: {
          name: highlight_options,
          tags: highlight_options
        }
      }

      self.__elasticsearch__.search({
        query: {
          multi_match: {
            query: params[:keyword],
            type: 'phrase_prefix',
            fields: ['name', 'tags']
          }
        },
        highlight: highlight,
        size: 20
      })
    end
  end
end
