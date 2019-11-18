# frozen_string_literal: true

class SpreadsheetService
  cattr_accessor :dest

  @@MAX_FILE_SIZE = 10 * 1024**2 # 10MiB
  @@MAX_FILES = 100
  @@WHITELIST = %w(.zip)
  @@COLS = {  name: "Name",
              tags: "Tags",
              file: "File" }

  def initialize(zip_file)
    @zip_file = zip_file
    @uploader = FileUploader.new
    @store_dir = Rails.root.join("public", @uploader.store_dir).to_path
  end

  def unzip
    checker = FileChecker.new(@zip_file)
    checker.exist!
    checker.blacklist!

    # Dealing with existing file
    Zip.on_exists_proc = true
    Zip.continue_on_exists_proc = true

    Zip::File.open(@zip_file) do |zip_file|
      num_files = 0
      base_name = SecureRandom.hex(4)
      self.dest = FileUtils.mkdir_p("#{@store_dir}/#{base_name}").first

      zip_file.each do |entry|
        checker.too_many!(++num_files)
        checker.too_large!(entry.size)
        entry.extract "#{dest}/#{entry.name}"
      end
    end

    spreadsheets = Dir.glob("#{dest}/**/*.xlsx")
    checker.no_spreadsheet!(spreadsheets)
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
end
