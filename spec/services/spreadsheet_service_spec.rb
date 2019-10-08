require 'rails_helper'

RSpec.describe SpreadsheetService, type: :model do
  let(:not_found) { file_path('404.zip') }
  let(:blacklist) { file_path('angkorwat.jpg') }

  it 'not found' do
    service = described_class.new(not_found)
    error_msg = I18n.t('.spreadsheet_service.not_found', filename: File.basename(not_found))

    expect { service.unzip }.to raise_error(RuntimeError, error_msg)
  end

  it 'is not in whitelist' do
    service = described_class.new(blacklist)
    whitelist = described_class.class_variable_get(:@@WHITELIST)
    error_msg = I18n.t('.spreadsheet_service.blacklist_ext', allowance: whitelist.to_sentence)

    expect { service.unzip }.to raise_error(RuntimeError, error_msg)
  end
end