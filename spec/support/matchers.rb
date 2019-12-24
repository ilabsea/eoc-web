# frozen_string_literal: true

RSpec::Matchers.define :be_unauthorize do |expected|
  match do |actual|
    actual["status"] == "bad_request" && \
    actual["error"] == "Unauthorize request"
  end
end
