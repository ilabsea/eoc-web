require 'rails_helper'

RSpec.describe Sop, type: :model do
  it { expect(subject.class).to respond_to(:search_highlight) }
  it { is_expected.to respond_to(:with_attachment) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'association' do
    it { should belong_to(:category).optional }
  end

  describe 'category_name' do
    before(:each) do
      @sop = FactoryBot.create :sop
    end

    it 'should return category name' do
      category = FactoryBot.create :category
      @sop.update(category_id: category.id)
      expect(@sop.category_name).to eq(category.name)
    end

    it 'should return empty string when sop has no category' do
      expect(@sop.category_name).to eq('')
    end
  end
end
