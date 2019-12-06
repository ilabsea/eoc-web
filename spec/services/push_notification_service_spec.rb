# frozen_string_literal: true

require "rails_helper"
require_relative "../support/fcm_fake"

RSpec.describe PushNotificationService do
  context "initialize" do
    let(:options) { { title: "Attention!", body: "H1N1 has new symptom!", data: { item: 1 } } }

    it "should have fcm key" do
      expect(FCM).to receive(:new).with(ENV["FIREBASE_SERVER_KEY"])
      described_class.new(options)
    end
  end

  context "send" do
    let(:options) { { title: "Attention!", body: "H1N1 has new symptom!", data: { item: 1 } } }
    let(:service) { described_class.new(options) }
    let(:topic_option) { { notification: { title: options[:title], body: options[:body] }, data: options[:data] } }

    it "chunks senders #prepare" do
      expect_any_instance_of(FCM).to receive(:send_to_topic).with("all", topic_option)
      service.send_to_all
    end
  end
end
