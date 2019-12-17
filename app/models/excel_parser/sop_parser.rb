# frozen_string_literal: true

class ExcelParser::SopParser
  def self.generate(file)
    xlsx = Roo::Spreadsheet.open(file)
    sheet = xlsx.sheet("sops")
    records = sheet.parse(name: "name", description: "description", file: "file", tags: "tags", category_name: "category")
    records.map { |record|
      attachment_path = "#{File.dirname(file)}/attachment/#{record[:file]}"
      record[:file] = record[:file].present? && File.exist?(attachment_path) ? attachment_path : ""
      record[:tags] = record[:tags].try(:split, " ") || []
      record
    }
  end
end
