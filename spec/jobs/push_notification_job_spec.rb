require 'rails_helper'

RSpec.describe PushNotificationJob, type: :job do
  describe "#perform_later" do
    let(:data) { { title: "title", body: "body message", data: { item: 1 } } }

    it "should send push notification" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        PushNotificationJob.perform_later("all", data)
      }.to have_enqueued_job.with("all", data).on_queue("default").at(:no_wait)
    end
  end
end
