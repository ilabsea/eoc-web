return unless Rails.env === 'development'

Category.__elasticsearch__.create_index! force: true
Sop.__elasticsearch__.create_index! force: true
Category.destroy_all
Sop.destroy_all

excel_path = Rails.root.join('public', 'samples', 'eoc.xlsx').to_s
raise "File #{File.basename(excel_path)} not exist" unless File.exist?(excel_path)

importer = Importer.new(excel_path)
importer.load
