# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }

    context "uniquness name with scope" do
      let!(:category) { create :category, name: "Animal" }
      let(:new_category) { build :category, name: "Animal" }

      it "should not allow duplicate name" do
        expect(new_category).to be_invalid
      end

      it "should not check with deleted record" do
        category.destroy
        expect(new_category).to be_valid
      end
    end
  end

  describe "association" do
    it { should have_many(:sops) }
  end

  describe "destroy" do
    before(:each) do
      @category = FactoryBot.create :category
    end

    it "should soft delete empty category" do
      @category.destroy
      expect(Category.count).to eq(0)
      expect(Category.only_deleted.count).to eq(1)
    end

    it "should not delete when has child category" do
      child_category = FactoryBot.create :category
      child_category.move_to_child_of(@category)

      @category.destroy
      expect(Category.count).to eq(2)
    end

    it "should not delete when has sop" do
      sop = FactoryBot.create :sop
      sop.update(category_id: @category.id)

      @category.destroy
      expect(Category.count).to eq(1)
    end

    describe :is_empty? do
      before(:each) do
        @category = FactoryBot.create :category
      end

      it "should return true" do
        expect(@category.is_empty?).to be true
      end

      it "should return false when has sub category" do
        child_category = FactoryBot.create :category
        child_category.move_to_child_of(@category)

        expect(@category.is_empty?).to be false
      end

      it "should not delete when has sop" do
        sop = FactoryBot.create :sop
        sop.update(category_id: @category.id)

        expect(@category.is_empty?).to be false
      end
    end
  end
end
