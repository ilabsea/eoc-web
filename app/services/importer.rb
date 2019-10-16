class Importer < SpreadsheetService
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
        msg = t('unprocessible', msg: sop.errors.full_messages.join(','))
        Rails.logger.warn(msg) 
      end
    end
  end
end