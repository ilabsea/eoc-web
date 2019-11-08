# frozen_string_literal: true

require "rails_helper"

RSpec.describe SopDecorator do
  let(:category) { create(:category) }
  let(:decorator) { described_class.new(name: "dengue", category: category.name, file: "") }

  it { have_const_defined(:WHITELIST_COLUMNS) }
  it { expect(decorator.save).to be_an_instance_of(Sop) }
  it { expect(decorator.save.category_name).to eq(category.name) }
end
