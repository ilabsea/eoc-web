# frozen_string_literal: true

class ExcelParser::SopParser < ExcelParser::Parser
  def generate
    xlsx = Roo::Spreadsheet.open(@excel_file)
    sheet = xlsx.sheet("sops")
    records = sheet.parse(name: "name", description: "description", file: "file", tag: "tags", category_name: "category")
    records.map { |record|
      
    }
  end

  private
    def attachment_path(record)
      attachment_path = attachment_dir + record[:file]
      record[:file].present? && File.exist?(attachment_path) ? attachment_path : ""
    end

    def attachment_dir
      @attachment_dir ||= File.dirname(@excel_file) + "/attachment/"
    end
end
