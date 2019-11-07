# frozen_string_literal: true

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
#  is_deleted     :boolean          default(FALSE)
#  tags           :text             default([]), is an Array
#

class Category < ApplicationRecord
  include ::SoftDeletable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :sops, class_name: "Sop"

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, conditions: -> { where(is_deleted: false) } }

  before_destroy :check_category

  acts_as_nested_set

  def is_empty?
    children.count.zero? && sops.count.zero?
  end

  private
    def check_category
      unless is_empty?
        errors[:base] << "category is not empty"
        throw :abort
      end
    end
end
