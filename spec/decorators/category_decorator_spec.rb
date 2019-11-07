require 'rails_helper'

RSpec.describe CategoryDecorator do
  let(:parent) { create(:category, name: 'viruses') }
  let(:decorator) { described_class.new(name: 'test', parent: parent.name) }
  
  it { have_const_define(:WHITELIST_COLUMNS) }
  it { expect(decorator.save).to be_an_instance_of(Category) }
  it { expect(decorator.save.parent.name).to eq(parent.name) }
end