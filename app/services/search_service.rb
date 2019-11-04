class SearchService
  def self.text_search(params)
    size = params[:items] || 10
    page = (params[:page] || 1).to_i
    from = (page - 1) * size

    query = params[:q].blank? ? self.get_all_query : self.matching_query(params)

    Elasticsearch::Model.search(query, [Sop, Category], {
      size: size,
      from: from
    })
  end

  private

  def self.get_all_query
    {
      query: {
        term: {
          is_deleted: false
        }
      }
    }
  end

  def self.matching_query(params)
    {
      query: {
        bool: {
          must: {
            multi_match: {
              query: params[:q],
              type: 'phrase_prefix',
              fields: ['name', 'tags', 'description']
            }
          },
          filter: {
            term: {
              is_deleted: false
            }
          }
        }
      },
      highlight: self.highligh_option
    }
  end

  def self.highligh_option
    fragment_options = {
      fragment_size: 180,
      number_of_fragments: 2,
    }

    highlight = {
      pre_tags: ["<em class='highlight'>"],
      post_tags: ["</em>"],
      fields: {
        name: fragment_options,
        tags: fragment_options
      }
    }

    highlight
  end
end
