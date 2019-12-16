# frozen_string_literal: true

class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(topic, data)
    service = ::PushNotificationService.new
    service.send_to_topic(topic, data)
  end
end
