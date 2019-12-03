class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(topci, data)
    service = ::PushNotificationService.new(data)
    service.send_to_topic(topic, data)
  end
end
