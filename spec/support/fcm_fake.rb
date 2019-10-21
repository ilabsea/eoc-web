class FCMFake < FCM
  def initialize key
    super(key)
  end

  def send ids, options
    { action: 'send', status: 200 }
  end
end
