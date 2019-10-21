class PushNotificationService
  @@server_key = 'xxx'
  @@max_count = 2

  def initialize(options = {})
    @title = options[:title]
    @body = options[:body]

    @fcm = ::FCMFake.new(@@server_key)
  end

  def notify tokens
    tokens.in_groups_of(@@max_count, false).each do |groups|
      send(groups, message_options)
    end
  end

  delegate :send, to: :@fcm

  private

  def message_options
    { 
      "notification": {
        "title": @title,
        "body": @body
      }
    }
  end
end
