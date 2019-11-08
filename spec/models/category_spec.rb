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

  describe 'destroy' do
    context 'emptry category' do
      let!(:category) { create(:category) }

      it 'should delete category' do
        category.destroy
        expect(Category.count).to eq(0)
      end

      it 'should should delete' do
        category.destroy
        expect(Category.only_deleted.count).to eq(1)
      end
    end

    context 'category with child' do
      let!(:category) { create(:category) }
      let!(:child_category) { create(:category, parent_id: category.id) }

      it 'should not be deleted' do
        category.destroy
        expect(Category.find(category.id)).to be_present
      end
    end

    context 'category with sop' do
      let!(:category) { create(:category) }
      let!(:sop) { create(:sop, category_id: category.id) }

      it 'should not be deleted' do
        category.destroy
        expect(Category.find(category.id)).to be_present
      end
    end
  end

  describe :is_empty? do
    let!(:category) { create :category }

    context 'empty' do
      it 'should return true' do
        expect(category.is_empty?).to be true
      end
    end

    context 'is not empty' do
      let!(:child_category) { create :category, parent_id: category.id }
      let!(:sop) { create :sop, category_id: category.id }

      it 'should return false when has sub category' do
        expect(category.is_empty?).to be false
      end

      it 'should not delete when has sop' do
        expect(category.is_empty?).to be false
      end
    end
  end
end
