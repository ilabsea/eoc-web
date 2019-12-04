class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(topic, data)
    service = ::PushNotificationService.new(data)
    service.send_to_all
  end
end
