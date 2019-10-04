class SpreadsheetService
  @@MAX_FILE_SIZE = 10 * 1024**2 # 10MiB
  @@MAX_FILES = 100
  @@WHITELIST_EXTENSIONS = %w(.zip)
  @@COLS = {  name: 'Name', 
              tags: 'Tags', 
              document_type: 'Document_type', 
              file: 'File' }

  def initialize(zip_file)
    extname = File.extname(zip_file)
    filename = File.basename(zip_file)

    raise t('not_found', filename: filename) unless File.exist?(zip_file)
    raise t('whitelist', allowance: @@WHITELIST_EXTENSIONS.to_sentence ) unless @@WHITELIST_EXTENSIONS.include?(extname)
    
    @zip_file = zip_file
    @uploader = FileUploader.new
    @store_dir = Rails.root.join('public', @uploader.store_dir).to_path
  rescue => err
    print err.message
  end

  # TODO #
  # .whitelisted files
  # .unicode file
  # .many other zip files (rar, gz, ...) are not yet support

  # .add pagy gem (pagination)
  # .excel bind with macro (option for document_type)

  # .nested sub-dir
  # .multiple spreadsheet file
  # .large file

  def unzip
    #Dealing with existing file
    Zip.on_exists_proc = true
    Zip.continue_on_exists_proc = true

    Zip::File.open(@zip_file) do |zip_file|
      num_files = 0
      base_name = File.basename(zip_file.name, '.zip')
      @dest = FileUtils.mkdir_p("#{@store_dir}/#{base_name}").first

      zip_file.each do |entry|
        raise t('too_many')  if ++num_files > @@MAX_FILES
        raise t('too_large') if entry.size > @@MAX_FILE_SIZE
        entry.extract "#{@dest}/#{entry.name}" 
      end
    end

    spreadsheets = Dir.glob("#{@dest}/*.xlsx")
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
        sop.with_attachment(@dest, row[:file].to_s) do |f|
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

  # load multiple speadsheet files & import
  # def load_sop_from_spreadsheet
  #   spreadsheets = Dir.glob("#{@dest}/*.xlsx")
  #   raise t('not_found') if spreadsheets.empty?

  #   spreadsheets.each { |xlsx| import(xlsx) }
  # end

  protected

  def log(type=:warn, msg)
    Rails.logger.send(type, msg)
  end

  def t(key, placeholder={})
    I18n.t(".xlsx_service.#{key}", {default: ''}.merge(placeholder))
  end

  # def archive path, files
  #   folder = Rails.root.join('public', 'uploads', 'roo_test').to_path
  #   file_names = ['Book1.xlsx', 'fish.jpg']
  #   zip_name = "#{folder}/archive.zip"

  #   Zip::File.open(zip_name, Zip::File::CREATE) do |zipfile|
  #     file_names.each do |filename|
  #       zipfile.add(filename, File.join(folder, filename))
  #     end
  #   end
  # end
end
