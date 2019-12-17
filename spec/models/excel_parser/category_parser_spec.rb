# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExcelParser::CategoryParser, type: :model do
  describe "#generate" do
    let(:parser_data) { described_class.generate(file_path("test.xlsx")) }

    it "should return correct data" do
      data = [
        { name: "root cat", parent_name: nil },
        { name: "cat 1", parent_name: "root cat" },
        { name: "cat 1.1", parent_name: "cat 2" },
        { name: "cat 1", parent_name: nil },
      ]
      expect(parser_data).to eq(data)
    end
  end
end
