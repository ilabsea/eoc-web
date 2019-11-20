# frozen_string_literal: true

class SpreadsheetService
  cattr_accessor :dest

  @@MAX_FILE_SIZE = 10 * 1024**2 # 10MiB
  @@MAX_FILES = 100
  @@WHITELIST = %w(.zip)

  def initialize(zip_file)
    @zip_file = zip_file
    @dest = Rails.root.join("public", "import", SecureRandom.hex(4)).to_path
  end

  def process
    extract_zip

    spreadsheets = Dir.glob("#{@dest}/**/*.xlsx")
    raise t("not_found") if spreadsheets.empty?
    importer = Importer.new(spreadsheets.first)
    importer.load
  end

  protected
    def log(type = :warn, msg)
      Rails.logger.send(type, msg)
    end

    def t(key, placeholder = {})
      I18n.t(".spreadsheet_service.#{key}", { default: "" }.merge(placeholder))
    end

  private
    def extract_zip
      Zip::File.open(@zip_file) do |zip_file|
        zip_file.each do |entry|
          entry.extract "#{@dest}/#{entry.name}"
        end
      end
    end
end
