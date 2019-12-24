# frozen_string_literal: true

class SopImportService
  def initialize(zip_file)
    @zip_file = zip_file
    @dest = Rails.root.join("tmp", "import", SecureRandom.hex(4)).to_path
  end

  def process
    extract_zip
    spreadsheet = Dir.glob("#{@dest}/**/*.xlsx").first
    raise I18n.t(".sop_import_service.not_found") if spreadsheet.nil?

    import_data(["category", "sop"], spreadsheet)

    FileUtils.remove_dir(@dest, true)
  end

  private
    def extract_zip
      Zip::File.open(@zip_file) do |zip_file|
        zip_file.each do |entry|
          entry.extract "#{@dest}/#{entry.name}"
        end
      end
    end

    def import_data(types, spreadsheet)
      types.each do |type|
        parser = ExcelParser::Parser.new(type: type, file: spreadsheet)
        importer = Importer.new(parser: parser, type: type)
        importer.import
      end
    end
end
