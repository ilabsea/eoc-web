require 'elasticsearch/model'

module Sops::Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.search(params)
      autoloadOption = {
        size: params[:size],
        from: params[:from]
      }.compact

      return self.__elasticsearch__.search({
        query: {
          term: {
            is_deleted: false
          }
        }
      }.merge(autoloadOption)) if params[:keyword].blank?

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
          bool: {
            must: {
              multi_match: {
                query: params[:keyword],
                type: 'phrase_prefix',
                fields: ['name', 'tags']
              }
            },
            filter: {
              term: {
                is_deleted: false
              }
            }
          }
        },
        # sort: [{id: 'asc'}],
        highlight: highlight
      }.merge( autoloadOption ) )
    end
  end
end
