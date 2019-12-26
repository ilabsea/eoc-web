# frozen_string_literal: true

class SopImportService
  def initialize(zip_file)
    @zip_file = zip_file
    @dest = Rails.root.join("tmp", "import", SecureRandom.uuid).to_path
    @spreadsheet = get_spreadsheet
  end

  def process
    result = validate()

    result[:category][:valids].each do |category|
      category.save
    end

    result[:sop][:valids].each do |sop|
      sop.save
    end

    FileUtils.remove_dir(@dest, true)
  end

  def validate
    raise I18n.t(".sop_import_service.not_found") if @spreadsheet.nil?
    result = {}
    ["category", "sop"].each do |type|
      parser = ExcelParser::Parser.new(type: type, file: @spreadsheet)
      importer = Importer.new(parser: parser)
      result[type.to_sym] = importer.validate
    end
    result
  end

  private
    def get_spreadsheet
      Zip::File.open(@zip_file) do |zip_file|
        zip_file.each do |entry|
          entry.extract "#{@dest}/#{entry.name}"
        end
      end

      Dir.glob("#{@dest}/**/*.xlsx").first
    end

    def import_data(types)
      types.each do |type|
        parser = ExcelParser::Parser.new(type: type, file: @spreadsheet)
        importer = Importer.new(parser: parser)
        importer.import
      end
    end
end
