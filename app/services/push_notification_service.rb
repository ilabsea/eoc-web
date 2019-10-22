class PushNotificationService
  SEND_THRESHOLD = 500

  def initialize(options = {})
    @title = options[:title]
    @body = options[:body]
  end

  def notify tokens
    tokens.in_groups_of(SEND_THRESHOLD, false).each do |groups|
      send(groups, message_options)
    end
  end

  delegate :send, to: :fcm

  private

  def fcm
    @fcm ||= ::FCM.new(ENV[FIREBASE_SERVER_KEY])
  end

  def message_options
    { 
      "notification": {
        "title": @title,
        "body": @body
      }
    }
  end
end
