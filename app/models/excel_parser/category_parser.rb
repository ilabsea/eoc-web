# frozen_string_literal: true

class ExcelParser::CategoryParser < ExcelParser::Parser
  def generate
    xlsx = Roo::Spreadsheet.open(@excel_file)
    sheet = xlsx.sheet("categories")
    records = sheet.parse(name: "name", parent_name: "parent")
  end
end
