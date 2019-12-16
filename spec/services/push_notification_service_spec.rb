# frozen_string_literal: true

require "rails_helper"
require_relative "../support/fcm_fake"

RSpec.describe PushNotificationService do
  context "initialize" do
    it "should have fcm key" do
      expect(FCM).to receive(:new).with(ENV["FIREBASE_SERVER_KEY"])
      described_class.new
    end
  end

  context "send to all topic" do
    let(:service) { described_class.new }
    let(:data) { { notification: { title: "Attention!", body: "H1N1 has new symptom!" }, data: { item: 1 } } }
    let(:topic) { "all" }

    it "send notification to topic" do
      expect_any_instance_of(FCM).to receive(:send_to_topic).with(topic, data)
      service.send_to_topic(topic, data)
    end
  end

  describe "#subscribe_to_topic" do
    let(:service) { described_class.new }
    let(:token) { FFaker::DizzleIpsum.characters }
    let(:topic) { "all" }

    it "subscribe to topic with provided token" do
      expect_any_instance_of(FCM).to receive(:topic_subscription).with(topic, token)
      service.subscribe_to_topic(topic, token)
    end
  end
end
