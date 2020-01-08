# frozen_string_literal: true

class PushNotificationService
  def initialize
    @fcm = ::FCM.new(Rails.application.credentials.app[:firebase_server_key])
  end

  def send_to_topic(topic, data)
    @fcm.send_to_topic(topic, data)
  end

  def subscribe_to_topic(topic, token)
    @fcm.topic_subscription(topic, token)
  end
end
