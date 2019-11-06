module SearchesHelper
  def hilite_name(sop)
    sop.try(:highlight).try(:name) ? sop.highlight.name.first : sop.name
  end

  def hilite_tags(sop)
    sop.try(:highlight).try(:tags) || sop.tags
  end
end
