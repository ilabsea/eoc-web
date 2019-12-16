# frozen_string_literal: true

return unless Rails.env === "development"

user = User.create(email: "admin@instedd.org", password: "password")
user.confirm

Category.destroy_all
Sop.destroy_all
Category.reindex
Sop.reindex

zip_path = Rails.root.join("sample", "sample.zip").to_s
raise "File #{File.basename(zip_path)} not exist" unless File.exist?(zip_path)

service = SopImportService.new(zip_path)
service.process
