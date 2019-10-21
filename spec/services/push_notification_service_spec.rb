require 'rails_helper'
require_relative '../support/fcm_fake'

RSpec.describe PushNotificationService do
  let(:options) { { title: 'Attention!', body: 'H1N1 has new symptom!' } }
  let(:notification) { described_class.new(options) }

  it 'chunks senders #prepare' do
    token_ids = %w(a1 b2 c3 d4 e5)
    expect( notification ).to receive(:send).exactly(3).times
    notification.notify token_ids
  end
end
