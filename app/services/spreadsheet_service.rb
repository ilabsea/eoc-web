class SpreadsheetService
  cattr_accessor :dest

  @@MAX_FILE_SIZE = 10 * 1024**2 # 10MiB
  @@MAX_FILES = 100
  @@WHITELIST = %w(.zip)
  @@COLS = {  name: 'Name', 
              tags: 'Tags', 
              document_type: 'Document_type', 
              file: 'File' }

  def initialize(zip_file)
    @zip_file = zip_file
    @uploader = FileUploader.new
    @store_dir = Rails.root.join('public', @uploader.store_dir).to_path
  end

  def unzip
    extname = File.extname(@zip_file)
    filename = File.basename(@zip_file)

    raise t('not_found', filename: filename) unless File.exist?(@zip_file)
    raise t('blacklist_ext', allowance: @@WHITELIST.to_sentence ) unless @@WHITELIST.include?(extname)

    #Dealing with existing file
    Zip.on_exists_proc = true
    Zip.continue_on_exists_proc = true

    Zip::File.open(@zip_file) do |zip_file|
      num_files = 0
      base_name = File.basename(zip_file.name, '.zip')
      self.dest = FileUtils.mkdir_p("#{@store_dir}/#{base_name}").first

      zip_file.each do |entry|
        raise t('too_many')  if ++num_files > @@MAX_FILES
        raise t('too_large') if entry.size > @@MAX_FILE_SIZE
        entry.extract "#{dest}/#{entry.name}" 
      end
    end

    spreadsheets = Dir.glob("#{dest}/*.xlsx")
    raise t('not_found') if spreadsheets.empty?
    yield spreadsheets.map { |f| Importer.new(f) } if block_given?
  end

  class Importer < self
    def initialize(f)
      @file = f
    end

    def load
      sheet_index = 0
      roo = Roo::Excelx.new(@file)

      sheet = roo.sheet(sheet_index)
      rows = sheet.parse(@@COLS)

      rows.each do |row|
        sop = Sop.new(row)
        sop.with_attachment(dest, row[:file].to_s) do |f|
          sop.file = f
        end

        unless sop.save
          sop.errors.full_messages.each do |msg|
            log msg
          end
        end
      end

    rescue => err
      log err.message
    end
  end

  protected

  def log(type=:warn, msg)
    Rails.logger.send(type, msg)
  end

  def t(key, placeholder={})
    I18n.t(".spreadsheet_service.#{key}", { default: '' }.merge(placeholder))
  end
end
