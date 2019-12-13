# frozen_string_literal: true

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
  searchkick \
    word_middle: [:name, :tags, :description],
    text_middle: [:name, :tags, :description]

  mount_uploader :file, FileUploader

  belongs_to :category, optional: true

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, conditions: -> { where(is_deleted: false) } }

  delegate :identifier, to: :file, allow_nil: true

  after_commit ->  { EsFileIndexJob.perform_later(id) }, \
                      if: :es_file_index?,
                      on: [:create, :update]

  def with_attachment(path, file)
    whitelist_files = /^[https?:\/\/]?[\S]+\/\S+\.(?:pdf|zip)$/

    return if File.extname(file).blank? || file.blank?
    return self.remote_file_url = file if file.scan(whitelist_files).present?

    File.open("#{path}/#{file}") { |f| yield f } if File.exist?("#{path}/#{file}")
  end

  def search_data
    {
      name: name,
      tags: tags,
      description: description
    }
  end

  def category_name
    category.try(:name) || ""
  end

  def self.create_record(data)
    category_id = Category.find_by(name: data[:category_name]).try(:id)
    sop = new(name: data[:name], description: data[:description], tags: data[:tags], category_id: category_id)

    if data[:file].present? #&& File.exist?(attachment_path)
      File.open(data[:file]) { |f| sop.file = f }
    end

    sop.save
  end

  private
    def es_file_index?
      ENV["ES_FILE_INDEXABLE"] == "true"
    end
end
