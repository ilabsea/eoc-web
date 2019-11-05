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
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

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
    whitelist_files = /^[https?:\/\/]?[\S]+\/\S+\.(?:pdf|zip)$/

    return if File.extname(file).blank? || file.blank?
    return self.remote_file_url = file if file.scan(whitelist_files).present?

    File.open("#{path}/#{file}") { |f| yield f } if File.exist?("#{path}/#{file}")
  end

  def category_name
    category.try(:name) || ''
  end
end
