require 'rails_helper'

RSpec.describe SopDecorator do
  let(:category) { create(:category) }
  it { have_const_defined(:WHITELIST_COLUMNS) }

  it '#save' do
    obj = described_class.new(name: 'dengue', category: category.name, file: '')
    saved = obj.save 

    expect(saved).to be_a(Sop)
    expect(saved.category_name).to eq(category.name)
  end
end
