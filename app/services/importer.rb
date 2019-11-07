class Importer
  def initialize(f)
    @file = f
  end

  def load
    xlsx = Roo::Spreadsheet.open(@file)

    xlsx.sheets.each do |sheet_name|
      sheet = xlsx.sheet(sheet_name)
      klazz = sheet_name.classify

      begin
        columns = "#{klazz}Decorator::WHITELIST_COLUMNS".constantize
        sheet.each(columns) do |row|
          decorator = "#{klazz}Decorator".constantize.new(row)
          decorator.save
        end
      rescue Exception => e
        Rails.logger.warn( t('unprocessible', msg: e.message) )
      end
    end
  end
end