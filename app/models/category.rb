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
  include ::SoftDeletable
  include Sops::Searchable
  
  has_many :sops, class_name: 'Sop'

  validates :name, presence: true
  validates :name, uniqueness: true

  before_destroy :destroy_category

  acts_as_nested_set

  def is_empty?
    children.count.zero? && sops.count.zero?
  end

  private

  def destroy_category
    delete if is_empty?
  end
end
