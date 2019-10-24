module Api::V1
  class CategoriesController < ApiController
    def show
      category = Category.find(params['id'])
      render json: category.children
    end
  end
end
