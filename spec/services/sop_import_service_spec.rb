# frozen_string_literal: true

require "rails_helper"

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
RSpec.describe SopImportService do
  let(:not_found) { file_path("404.zip") }
  let(:archive) { file_path("Archive.zip") }

  describe "#process" do
    context "missing excel file" do
      let(:service) { described_class.new({ compress_file: file_path("archive-no-excel.zip") }) }

      it "raise file not found message" do
        expect { service.process }.to raise_error(RuntimeError, I18n.t(".sop_import_service.not_found"))
      end
    end

    context "import categories" do
      before(:each) do
        @service = described_class.new({ compress_file: file_path("Archive.zip") })
        @service.process
      end

      let(:root_category) { Category.find_by(name: "root cat") }
      let(:category1) { Category.find_by(name: "cat 1") }
      let(:category2) { Category.find_by(name: "cat 1.1") }

      it "import categories" do
        expect(Category.count).to eq(3)
      end

      it "import root category" do
        expect(root_category.parent_id).to be_nil
      end

      it "import child category" do
        expect(category1.parent_id).to eq(root_category.id)
      end

      it "ignore parent category when it's not exist" do
        expect(category2.parent_id).to be_nil
      end
    end

    context "import sops" do
      before(:each) do
        @service = described_class.new(compress_file: file_path("Archive.zip"))
        @service.process
      end

      let(:sop1) { Sop.find_by(name: "Hepatitis A") }
      let(:sop2) { Sop.find_by(name: "Acute") }

      it "import sops" do
        expect(Sop.count).to eq(3)
      end

      it "import correct sop attachment" do
        expect(sop1.file.path).to be_truthy
      end

      it "ignore sop attachment when attachment file is missing" do
        expect(sop2.file.path).to be_falsy
      end

      it "import sop description" do
        expect(sop1.description).to be_truthy
        expect(sop2.description).to be_nil
      end

      it "import tags" do
        expect(sop1.tags).to match_array(["hepatitis-a", "high-danger"])
        expect(sop2.tags).to be_empty
      end
    end
  end

  describe "#validate" do
    context "missing excel file" do
      let(:service) { described_class.new(compress_file: file_path("archive-no-excel.zip")) }

      it "raise file not found message" do
        expect { service.validate }.to raise_error(RuntimeError, I18n.t(".sop_import_service.not_found"))
      end
    end

    context "import categories" do
      before(:each) do
        create(:category, name: "cat 1.1")
        @service = described_class.new(compress_file: file_path("Archive.zip"))
        @result = @service.validate
      end

      it "return existed records" do
        expect(@result[:category][:exists].first.name).to eq("cat 1.1")
        expect(@result[:category][:exists].count).to eq(1)
      end

      it "return valid records" do
        expect(@result[:category][:valids].first.name).to eq("root cat")
        expect(@result[:category][:valids].count).to eq(3)
      end

      it "return errors records" do
        expect(@result[:category][:errors].first.name).to be_nil
        expect(@result[:category][:errors].count).to eq(1)
      end
    end
  end
end
