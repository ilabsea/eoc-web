# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExcelParser::SopParser, type: :model do
  describe "#generate" do
    let(:parser_data) { described_class.generate(file_path("test.xlsx")) }

    it "should return correct data" do
      data = [
        { name: "Hepatitis A", description: "Hepatitis A usually does not …", file: file_path("attachment/Acute.pdf"), tags: ["hepatitis-a", "high-danger"], category_name:  "cat 1" },
        { name: "Animal", description: nil, file: "", tags: [], category_name: nil },
        { name: "nothing", description: nil, file: "", tags: [], category_name: nil }
      ]
      expect(parser_data).to eq(data)
    end
  end
end
