class Importer
  def initialize(f)
    @file = f
  end

  def load
    xlsx = Roo::Spreadsheet.open(@file)

    sheets = xlsx.sheets
    sheets.each do |sheet_name|
      sheet = xlsx.sheet(sheet_name)
      klazz = sheet_name.classify

      begin
        columns = "#{klazz}Decorator::WHITELIST_COLUMNS".constantize
        sheet.each(columns) do |hash|
          decorator = "#{klazz}Decorator".constantize.new(hash)
          decorator.save
        end
      rescue Exception => e
        msg = t('unprocessible', msg: e.message)
        Rails.logger.warn(msg)
      end
    end
  end
end