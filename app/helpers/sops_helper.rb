module SopsHelper
  def name fileurl
    File.basename(fileurl).split('-', 2)[1]
  end
end
