# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  name           :string
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#

class Category < ApplicationRecord
  has_many :children, class_name: 'Category', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :sops, class_name: 'Sop'

  before_destroy :destroy_category

  acts_as_nested_set

  def is_empty?
    children.count.zero? && sops.count.zero?
  end

  private

  def destroy_category
    self.destroy if self.is_empty?
  end
end
