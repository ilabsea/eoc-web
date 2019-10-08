require 'rails_helper'

RSpec.describe SpreadsheetService, type: :model do
  let(:not_found) { file_path('404.zip') }
  let(:blacklist) { file_path('blacklist.mp3') }

  it 'not found' do
    service = described_class.new(not_found)
    expect { service.unzip }.to raise_error(RuntimeError, I18n.t('.spreadsheet_service.not_found', filename: File.basename(not_found)))
  end
end