# frozen_string_literal: true

class SopDecorator < BaseDecorator
  WHITELIST_COLUMNS = {
    name: "name",
    description: "description",
    file: "file",
    tags: "tags",
    category: "category"
  }

  def initialize(attr)
    @attr ||= attr
  end

  def save
    path = Rails.root.join("public", "samples", "pdf").to_s
    Sop.create do |sop|
      sop.name = @attr[:name]
      sop.description = @attr[:description]
      sop.with_attachment(path, @attr[:file]) do |file|
        sop.file = file
      end
      sop.tags = @attr[:tags]
      sop.category = category(@attr[:category])
    end
  end
end
