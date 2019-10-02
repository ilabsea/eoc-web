class Sop < ApplicationRecord
  include Sops::Searchable
  enum document_type: [:document, :folder]

  mount_uploader :file, FileUploader

  belongs_to :category, optional: true
  # serialize :tags

  validates :name, presence: true, uniqueness: true
  after_commit :remove_file!, on: :destroy

  def self.search_highlight(params)
    response = self.search(params)

    SopSearchResultPresenter.new(response).results
  end

  def with_attachment(file)
    return unless document?
    return self.remote_file_url = file if URI.parse(file).absolute?

    path = "public/uploads/roo_test/#{file}"
    File.open(path) { |f| yield f } if File.exist?(path)
  end
end
