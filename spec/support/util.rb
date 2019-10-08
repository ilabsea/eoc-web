module Util
  module Methods
    def file_path *paths
      File.expand_path(File.join('spec/fixtures/files', *paths), File.dirname(__FILE__))
    end
  end
end