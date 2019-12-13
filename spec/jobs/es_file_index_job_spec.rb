# frozen_string_literal: true

require "rails_helper"

RSpec.describe EsFileIndexJob, type: :job do
  ActiveJob::Base.queue_adapter = :test
  let(:sop) { create(:sop) }

  it "enqueues the job" do
    expect {
      EsFileIndexJob.perform_later(sop.id)
    }.to have_enqueued_job.with(sop.id).on_queue("default").at(:no_wait)
  end
end
