# frozen_string_literal: true

require "rails_helper"

RSpec.describe BaseDecorator do
  let(:category) { create(:category) }

  it { is_expected.to respond_to(:category).with(1).argument }

  it "#category" do
    obj = subject.category(category.name)

    expect(obj.name).to eq(category.name)
    expect(obj).to be_a(Category)
  end
end
