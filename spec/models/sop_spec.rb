require 'rails_helper'

RSpec.describe Sop, type: :model do
  it { expect(subject.class).to respond_to(:search_highlight) }
  it { is_expected.to respond_to(:with_attachment) }

  describe 'attributes' do
    it { should define_enum_for(:document_type).with_values([:document, :folder]) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'association' do
    it { should belong_to(:category).optional }
  end
end
