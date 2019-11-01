module SopsHelper
  def name fileurl
    File.basename(fileurl).split('-', 2)[1]
  end

  def get_url(sop)
    sop
  end
end
