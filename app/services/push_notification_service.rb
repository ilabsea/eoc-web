# frozen_string_literal: true

class PushNotificationService
  def initialize(options = {})
    @title = options[:title]
    @body = options[:body]
    @data = options[:data]
    @fcm = ::FCM.new(ENV["FIREBASE_SERVER_KEY"])
  end

  def send_to_all
    @fcm.send_to_topic("all", topic_message_options)
  end

  private
    def topic_message_options
      {
        notification: {
          title: @title,
          body: @body
        },
        data: @data
      }
    end
end
