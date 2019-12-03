# frozen_string_literal: true

class PushNotificationService
  SEND_THRESHOLD = 500

  def initialize(options = {})
    @title = options[:title]
    @body = options[:body]
    @fcm = ::FCM.new(ENV["FIREBASE_SERVER_KEY"])
  end

  def notify(tokens)
    tokens.in_groups_of(SEND_THRESHOLD, false).each do |groups|
      @fcm.send(groups, message_options)
    end
  end

  def notify_with_key(token, data)
    # data = { notification: { title: '', body: '' }, data: {} }
    @fcm.send_with_notification_key(token, data: data, collapse_key: "updated_score")
  end

  def send_to_topic(name, data)
    @fcm.send_to_topic(name, data)
  end

  # delegate :send, :send_with_notification_key, to: :fcm

  private
    # def fcm
      # @fcm ||= ::FCM.new(ENV["FIREBASE_SERVER_KEY"])
    # end

    def message_options
      {
        "notification": {
          "title": @title,
          "body": @body
        }
      }
    end
end
