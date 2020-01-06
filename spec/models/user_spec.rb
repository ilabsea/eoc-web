# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "role" do
    it { should define_enum_for(:role).with_values({ admin: 1, user: 2 }) }

    it "should assign role 'user' by default" do
      user = User.new
      expect(user.role).to eq("user")
    end

    it "should assign locale 'en' by default" do
      user = User.new
      expect(user.locale).to eq("en")
    end

    it "should accept limited value for locale" do
      expect(subject).to validate_inclusion_of(:locale).in_array(%w(en km))
    end
  end
end
