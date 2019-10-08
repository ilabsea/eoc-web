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

FactoryBot.define do
  factory :sop do
    name { 'name' }
    tags { 'tags1 tags2' }
  end
end
