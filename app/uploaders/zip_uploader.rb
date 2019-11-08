class ZipUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_whitelist
    %w(zip)
  end
end
