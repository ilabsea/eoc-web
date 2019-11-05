require 'rails_helper'

RSpec.describe CategoryDecorator do
  let(:parent) { create(:category, name: 'viruses') }
  
  it { have_const_define(:WHITELIST_COLUMNS) }

  it '#save' do
    obj = described_class.new(name: 'test', parent: parent.name)
    saved = obj.save 

    expect(saved).to be_an_instance_of(Category)
    expect(saved.parent.name).to eq(parent.name)
  end
end