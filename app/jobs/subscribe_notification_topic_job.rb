# frozen_string_literal: true

class SubscribeNotificationTopicJob < ApplicationJob
  queue_as :default

  def perform(topic, token)
    notification_service = PushNotificationService.new
    notification_service.subscribe_to_topic(topic, token)
  end
end
