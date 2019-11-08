# frozen_string_literal: true

require "rails_helper"
require_relative "../support/fcm_fake"

RSpec.describe PushNotificationService do
  context "send" do
    let(:options) { { title: "Attention!", body: "H1N1 has new symptom!" } }
    let(:fake) { FCMFake.new("xxx") }
    let(:notification) { described_class.new(options) }
    let(:token_ids) { %w(a1 b2 c3 d4 e5) }

    before(:each) {
      allow(notification).to receive(:fcm).and_return(fake)
      stub_const("#{described_class}::SEND_THRESHOLD", 2)
    }

    it "chunks senders #prepare" do
      expect(notification).to receive(:send).exactly(3).times

      notification.notify token_ids
    end
  end
end
