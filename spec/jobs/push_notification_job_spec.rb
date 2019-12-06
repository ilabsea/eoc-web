require 'rails_helper'

RSpec.describe PushNotificationJob, type: :job do
  describe "#perform_later" do
    let(:data) { { notification: { title: "title", body: "body message" }, data: { item: 1 } } }

    it "should send push notification" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        PushNotificationJob.perform_later("all", data)
      }.to have_enqueued_job.with("all", data).on_queue("default").at(:no_wait)
    end
  end

  describe "#perform" do
    let(:job) { described_class.new }
    let(:data) { { notification: { title: "title", body: "body message" }, data: { item: 1 } } }
    let(:topic) { "all" }

    it "should send push notification to topic" do
      expect_any_instance_of(PushNotificationService).to receive(:send_to_topic).with(topic, data)
      job.perform(topic, data)
    end
  end
end
