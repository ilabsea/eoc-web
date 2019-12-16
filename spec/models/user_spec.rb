# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "role" do
    it { should define_enum_for(:role).with_values({ admin: 1, user: 2 }) }

    it "should assign role 'user' by default" do
      user = User.new
      expect(user.role).to eq("user")
    end
  end
end
