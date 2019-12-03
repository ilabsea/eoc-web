class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(data)
    service = ::PushNotificationService.new(data)
    service.send_to_topic("all", data)
  end
end
