module SopsHelper
  def name fileurl
    File.basename(fileurl).split('-', 2)[1]
  end

  def get_url(sop)
    sop
  end

  def hilite_name(sop)
    sop.try(:highlight).try(:name) ? sop.highlight.name.first : sop.name
  end

  def hilite_tags(sop)
    sop.try(:highlight).try(:tags) || sop.tags
  end

end
