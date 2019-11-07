class CategoryDecorator < BaseDecorator
  WHITELIST_COLUMNS = {
    name: 'name', 
    parent: 'parent'
  }
  
  def initialize(attr)
    @attr ||= attr
  end

  def save
    Category.create do |category|
      category.name = @attr[:name]
      category.parent = category(@attr[:parent])
    end
  end
end