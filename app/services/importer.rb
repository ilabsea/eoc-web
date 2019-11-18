# frozen_string_literal: true

class Importer
  def initialize(f)
    @file = f
  end

  def load
    xlsx = Roo::Spreadsheet.open(@file)
    create_categories(xlsx)
    create_sops(xlsx)
  end

  private
    def create_categories(xlsx)
      sheet = xlsx.sheet("categories")
      sheet.each(name: "name", parent_name: "parent") do |data|
        next if Category.find_by(name: data[:name]).present?

        parent_category = Category.find_by(name: data[:parent_name])
        Category.create(name: data[:name], parent_id: parent_category.try(:id))
      end
    end

    def create_sops(xlsx)
      sheet = xlsx.sheet("sops")
      sheet.each(name: "name", description: "description", file: "file", tag: "tags", category_name: "category") do |data|
        data.each_value { |v| v.try(:strip!) }
        next if Sop.find_by(name: data[:name]).present?

        category = Category.find_by(name: data[:category_name])
        tags = data[:tag].try(:split, " ")

        sop = Sop.new(name: data[:name], description: data[:description], tags: tags, category_id: category.try(:id))

        attachment_path = "#{File.dirname(@file)}/attachment/#{data[:file]}"

        if data[:file].present? && File.exist?(attachment_path)
          File.open(attachment_path) { |f| sop.file = f }
        end

        sop.save
      end
    end
end
