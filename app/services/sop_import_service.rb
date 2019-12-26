# frozen_string_literal: true

class SopImportService
  attr_reader :destination

  def initialize(attributes)
    @compress_file = attributes[:compress_file]
    @destination = attributes[:destination] || Rails.root.join("tmp", "import", SecureRandom.uuid).to_path
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

    FileUtils.remove_dir(@destination, true)
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
      if @compress_file.present? && @spreadsheet.nil?
        Zip::File.open(@compress_file) do |files|
          files.each do |entry|
            entry.extract "#{@destination}/#{entry.name}"
          end
        end
      end

      Dir.glob("#{@destination}/**/*.xlsx").first
    end

    def import_data(types)
      types.each do |type|
        parser = ExcelParser::Parser.new(type: type, file: @spreadsheet)
        importer = Importer.new(parser: parser)
        importer.import
      end
    end
end
