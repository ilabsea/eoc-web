module SopsHelper
  def name fileurl
    File.basename(fileurl).split('-')[-1]
  end
end
