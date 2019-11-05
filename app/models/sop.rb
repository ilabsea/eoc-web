# == Schema Information
#
# Table name: sops
#
#  id          :bigint           not null, primary key
#  name        :string
#  file        :string
#  tags        :text             default([]), is an Array
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  is_deleted  :boolean          default(FALSE)
#

class Sop < ApplicationRecord
  include ::SoftDeletable
  include Sops::Searchable

  mount_uploader :file, FileUploader

  belongs_to :category, optional: true

  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false, conditions: -> { where(is_deleted: false) }}

  after_commit :remove_file!, on: :destroy

  delegate :identifier, to: :file, allow_nil: true

  def self.search_highlight(params)
    response = self.search(params)

    SopSearchResultPresenter.new(response).results
  end

  def with_attachment(path, file)
    return if file.blank?
    return self.remote_file_url = file if URI.parse(file).absolute?

    File.open("#{path}/#{file}") { |f| yield f } if File.exist?("#{path}/#{file}")
  end

  def category_name
    category.try(:name) || ''
  end
end
