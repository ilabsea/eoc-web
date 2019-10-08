require 'rails_helper'

RSpec.describe SpreadsheetService, type: :model do
  let(:not_found) { file_path('404.zip') }
  let(:blacklist) { file_path('angkorwat.jpg') }
  let(:archive) { file_path('Archive.zip') }

  it 'raise error when zip file not found' do
    service = described_class.new(not_found)
    error_msg = I18n.t('.spreadsheet_service.not_found', filename: File.basename(not_found))

    expect { service.unzip }.to raise_error(RuntimeError, error_msg)
  end

  it 'raise error when not in whitelist' do
    service = described_class.new(blacklist)
    whitelist = described_class.class_variable_get(:@@WHITELIST)
    error_msg = I18n.t('.spreadsheet_service.blacklist_ext', allowance: whitelist.to_sentence)

    expect { service.unzip }.to raise_error(RuntimeError, error_msg)
  end

  it 'return array of importer instances' do
    service = described_class.new(archive)

    service.unzip do |excels| 
      expect(excels).to all(be_a(described_class::Importer)) 
    end
  end
end