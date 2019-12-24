# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExcelParser::Parser, type: :model do
  describe "validation" do
    context "accepted type" do
      it "should accept 'sop' type" do
        parser = ExcelParser::Parser.new(type: "sop")
        expect(parser.valid?).to eq(true)
      end

      it "should accept 'category' type" do
        parser = ExcelParser::Parser.new(type: "category")
        expect(parser.valid?).to eq(true)
      end
    end

    context "wrong type" do
      it "should not pass validation" do
        parser = ExcelParser::Parser.new({ type: nil })
        parser.valid?
        expect(parser.errors.messages[:type]).to eq(["is not included in the list"])
      end
    end
  end

  describe "#rows" do
    context "valid type" do
      let(:file) { file_path("test.xlsx") }
      let(:row_data) { { name: "testing", tags: [ "high" ] } }

      it "should return sop data" do
        allow(ExcelParser::SopParser).to receive(:generate).with(file).and_return(row_data)
        parser = ExcelParser::Parser.new(type: "sop", file: file)
        expect(parser.rows).to eq(row_data)
      end

      it "should return sop data" do
        allow(ExcelParser::CategoryParser).to receive(:generate).with(file).and_return(row_data)
        parser = ExcelParser::Parser.new(type: "category", file: file)
        expect(parser.rows).to eq(row_data)
      end
    end

    context "invalid type" do
      let(:parser) { ExcelParser::Parser.new(type: "random type") }

      it "should return nil" do
        expect(parser.rows).to be_nil
      end
    end
  end
end
