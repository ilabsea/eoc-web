# == Schema Information
#
# Table name: sops
#
#  id            :bigint           not null, primary key
#  name          :string
#  file          :string
#  tags          :text
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  document_type :integer          default("document")
#

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
end
