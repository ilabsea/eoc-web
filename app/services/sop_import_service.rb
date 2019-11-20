# frozen_string_literal: true

class SopImportService
  def initialize(zip_file)
    @zip_file = zip_file
    @dest = Rails.root.join("public", "import", SecureRandom.hex(4)).to_path
  end

  def process
    extract_zip

    spreadsheets = Dir.glob("#{@dest}/**/*.xlsx")
    raise I18n.t(".sop_import_service.not_found") if spreadsheets.empty?


    xlsx = Roo::Spreadsheet.open(spreadsheets.first)
    create_categories(xlsx)

    dir_path = File.dirname(spreadsheets.first) + "/attachment"
    create_sops(xlsx, dir_path)
  end

  protected
    def log(type = :warn, msg)
      Rails.logger.send(type, msg)
    end

  private
    def extract_zip
      Zip::File.open(@zip_file) do |zip_file|
        zip_file.each do |entry|
          entry.extract "#{@dest}/#{entry.name}"
        end
      end
    end

    def create_categories(xlsx)
      sheet = xlsx.sheet("categories")
      records = sheet.parse(name: "name", parent_name: "parent")
      records.each do |record|
        next if Category.find_by(name: record[:name]).present?
        parent_category = Category.find_by(name: record[:parent_name])
        Category.create(name: record[:name], parent_id: parent_category.try(:id))
      end
    end

    def create_sops(xlsx, dir_path)
      sheet = xlsx.sheet("sops")
      records = sheet.parse(name: "name", description: "description", file: "file", tag: "tags", category_name: "category")

      records.each do |record|
        record.each_value { |v| v.try(:strip!) }
        next if Sop.find_by(name: record[:name]).present?

        category = Category.find_by(name: record[:category_name])
        tags = record[:tag].present? ? record[:tag].split(" ") : []
        attachment_path = "#{dir_path}/#{record[:file]}"
        sop = Sop.new(name: record[:name], description: record[:description], tags: tags, category_id: category.try(:id))

        if record[:file].present? && File.exist?(attachment_path)
          File.open(attachment_path) { |f| sop.file = f }
        end

        sop.save
      end
    end
end
