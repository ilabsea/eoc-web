# frozen_string_literal: true

class ExcelParser::CategoryParser < ExcelParser::Parser
  def self.generate(file)
    xlsx = Roo::Spreadsheet.open(file)
    sheet = xlsx.sheet("categories")
    records = sheet.parse(name: "name", parent_name: "parent")
  end
end
