module SopsHelper
  def name fileurl
    File.basename(fileurl).split('-', 2)[1]
  end

  def get_url(sop)
    sop
  end

  def return_url
    @sop.category_id.present? ? category_path(@sop.category_id) : categories_path
  end
end
