return unless Rails.env === 'development'

Category.__elasticsearch__.create_index!(force: true)
Sop.__elasticsearch__.create_index!(force: true)

conn = ActiveRecord::Base.connection
conn.execute('DELETE FROM categories;')
conn.execute('DELETE FROM sops;')

Sop.all.map &:remove_file!

excel_path = Rails.root.join('public', 'samples', 'eoc.xlsx').to_s
raise 'file not exist' unless File.exist?(excel_path)
xlsx = Roo::Spreadsheet.open(excel_path)

sheets = xlsx.sheets
sheets.each do |sheet_name|
  sheet = xlsx.sheet(sheet_name)
  klazz = sheet_name.classify

  columns = "#{klazz}Decorator::WHITELIST_COLUMNS".constantize
  sheet.each(columns) do |hash|
    decorator = "#{klazz}Decorator".constantize.new(hash)
    decorator.save
  end
end
