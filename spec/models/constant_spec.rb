# frozen_string_literal: true

require "rails_helper"

RSpec.describe Constant, type: :model do
  describe "class constant" do
    it "should define UPLOAD_STEP" do
      expect(Constant::UPLOAD_STEP).to eq("upload step")
    end

    it "should define VALIDATE_STEP" do
      expect(Constant::VALIDATE_STEP).to eq("validate step")
    end

    it "should define VALIDATE_STEP" do
      expect(Constant::COMPLETE_STEP).to eq("complete step")
    end
  end
end
