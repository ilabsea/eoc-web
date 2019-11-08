# frozen_string_literal: true

class FileChecker < SpreadsheetService
  def initialize(zip)
    @zip = zip
  end

  def exist!
    filename = File.basename(@zip)
    raise t("not_found", filename: filename) unless File.exist?(@zip)
  end

  def blacklist!
    extname = File.extname(@zip)
    raise t("blacklist_ext", allowance: @@WHITELIST.to_sentence) unless @@WHITELIST.include?(extname)
  end

  def too_many!(num_files)
    raise t("too_many")  if num_files > @@MAX_FILES
  end

  def too_large!(size)
    raise t("too_large") if size > @@MAX_FILE_SIZE
  end

  def no_spreadsheet!(spreadsheets)
    raise t("not_found") if spreadsheets.empty?
  end
end
