# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sop, type: :model do
  it { is_expected.to respond_to(:with_attachment) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "association" do
    it { should belong_to(:category).optional }
  end

  describe "callback" do
    context "after_commit" do
      let(:sop) { create(:sop) }
      ActiveJob::Base.queue_adapter = :test

      it "does not enqueues any job when ES_FILE_INDEXABLE=false" do
        ENV["ES_FILE_INDEXABLE"] = "false"
        expect { sop }.not_to have_enqueued_job
      end

      it "enqueues a job when ES_FILE_INDEXABLE=true" do
        ENV["ES_FILE_INDEXABLE"] = "true"

        expect { sop }.to have_enqueued_job.on_queue("default")\
                                            .at_least(1).times
      end
    end
  end

  describe "destroy" do
    before(:each) do
      @sop = FactoryBot.create :sop
    end

    it "should soft delete item" do
      @sop.destroy
      expect(Sop.count).to eq(0)
      expect(Sop.unscoped.count).to eq(1)
    end
  end

  describe "category_name" do
    before(:each) do
      @sop = FactoryBot.create :sop
    end

    it "should return category name" do
      category = FactoryBot.create :category
      @sop.update(category_id: category.id)
      expect(@sop.category_name).to eq(category.name)
    end

    it "should return empty string when sop has no category" do
      expect(@sop.category_name).to eq("")
    end
  end
end
