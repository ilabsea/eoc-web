require 'rails_helper'

RSpec.describe SubscribeNotificationTopicJob, type: :job do
  describe "#perform_later" do
    let(:token) { FFaker::DizzleIpsum.characters }
    let(:topic) { "all" }

    it "should add job to queue" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SubscribeNotificationTopicJob.perform_later(topic, token)
      }.to have_enqueued_job.with(topic, token).on_queue("default").at(:no_wait)
    end
  end

  describe "#perform" do
    let(:token) { FFaker::DizzleIpsum.characters }
    let(:topic) { "all" }
    let(:job) { described_class.new }

    it "should subscribe to notification topic" do
      expect_any_instance_of(PushNotificationService).to receive(:subscribe_to_topic).with(topic, token)
      job.perform(topic, token)
    end
  end
end
