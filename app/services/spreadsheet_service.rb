class SpreadsheetService
  @@COLS = {  name: 'Name', 
              tags: 'Tags', 
              document_type: 'Document_type', 
              file: 'File' }

  def initialize(file='public/uploads/roo_test/Book1.xlsx')
    @file = file
  end

  def import
    # force_clean!
    
    rows.each do |row|
      sop = Sop.new(row)
      sop.with_attachment(row[:file].to_s) do |f|
        sop.file = f
      end
      if sop.save
        p '*'
      else
        sop.errors.full_messages.each do |e|
          p e
        end 
      end
    end
  end

  def archive
    folder = Rails.root.join('public', 'uploads', 'roo_test').to_path
    file_names = ['Book1.xlsx', 'fish.jpg']
    zip_name = "#{folder}/archive.zip"

    Zip::File.open(zip_name, Zip::File::CREATE) do |zipfile|
      file_names.each do |filename|
        zipfile.add(filename, File.join(folder, filename))
      end
    end
  end

  private

  def force_clean!
    Sop.delete_all
  end

  def roo
    @roo ||= Roo::Excelx.new(@file)
  end

  def sheet
    @sheet ||= roo.sheet(0)
  end

  def rows
    @rows ||= sheet.parse(@@COLS)
  end
end
