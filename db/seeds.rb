# frozen_string_literal: true

return unless Rails.env === "development"

user = User.create_or_find_by(email: "admin@instedd.org") do |u|
  u.password = "password"
end
user.confirm

Category.destroy_all
Sop.destroy_all
Category.reindex
Sop.reindex

zip_path = Rails.root.join("sample", "sample.zip").to_s
raise "File #{File.basename(zip_path)} not exist" unless File.exist?(zip_path)

service = SopImportService.new(zip_path)
service.process
