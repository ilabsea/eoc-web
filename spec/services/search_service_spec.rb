# frozen_string_literal: true

require "rails_helper"

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
RSpec.describe SearchService, type: :service do
  describe :text_search do
    before(:all) do
      DatabaseCleaner.start
      @sop = create(:sop, :reindex, name: "H1N1 Outbreak", tags: ["Level5", "High"], description: "A very long sop description")
      @category = create(:category, :reindex, name: "Outbreak Category", tags: ["High", "Alert"])
    end

    after(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end

    context "match name" do
      it "return match sop" do
        results = SearchService.text_search(q: "H1N1")
        expect(results[0]).to eq(@sop)
      end

      it "return match category" do
        results = SearchService.text_search(q: "ategor")
        expect(results[0]).to eq(@category)
      end

      it "return all results" do
        results = SearchService.text_search(q: "utbrea")
        expect(results.total_count).to eq(2)
      end
    end

    context "match tags" do
      it "return match sop" do
        results = SearchService.text_search(q: "Level")
        expect(results[0]).to eq(@sop)
      end

      it "return match category" do
        results = SearchService.text_search(q: "Aler")
        expect(results[0]).to eq(@category)
      end

      it "return all results" do
        results = SearchService.text_search(q: "high")
        expect(results.total_count).to eq(2)
      end
    end

    context "match description" do
      it "return match sop" do
        results = SearchService.text_search(q: "long")
        expect(results[0]).to eq(@sop)
      end

      it "return all results" do
        results = SearchService.text_search(q: "description")
        expect(results.total_count).to eq(1)
      end
    end

    context "does not match any record" do
      it "return no result" do
        results = SearchService.text_search(q: "query")
        expect(results.total_count).to eq(0)
      end
    end

    context "with specified per_page" do
      let(:results) { SearchService.text_search(q: "high", per_page: 1) }
      it "should return correct per page result" do
        expect(results.per_page).to eq(1)
      end

      it "should return correct total pages" do
        expect(results.total_pages).to eq(2)
      end
    end
  end
end
