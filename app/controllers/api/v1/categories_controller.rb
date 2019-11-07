# frozen_string_literal: true

module Api::V1
  class CategoriesController < ApiController
    def show
      category = Category.find(params["id"])
      render json: { sops: category.sops,
                      children: category.children }
    end
  end
end
