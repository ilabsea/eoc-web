# frozen_string_literal: true

class BaseDecorator
  def category(category_name)
    @category ||= Category.find_by(name: category_name)
  end
end
