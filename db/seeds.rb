# frozen_string_literal: true

return unless Rails.env === "development"

user = User.create(email: "admin@instedd.org", password: "password")
user.confirm

Category.__elasticsearch__.create_index! force: true
Sop.__elasticsearch__.create_index! force: true
Category.destroy_all
Sop.destroy_all

excel_path = Rails.root.join("sample", "eoc.xlsx").to_s
raise "File #{File.basename(excel_path)} not exist" unless File.exist?(excel_path)

importer = Importer.new(excel_path)
importer.load
