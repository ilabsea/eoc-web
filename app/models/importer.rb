class Importer
  include ActiveModel::Validation
  include ActiveModel::Conversion

  VALID_IMPORT_TYPE = %(sop category)

  validates :import_type, inclusion: { in: VALID_IMPORT_TYPE }

  attr_reader :parser, :import_type

  def initialize(attributes={})
    @parser = attributes[:parser]
    @import_type = attributes[:import_type]
  end

  def import
    if valid?
      rows.each do |row|
        next if import_factory.find_by(name: row.name).present?
        import_factory.create_record(row)
      end
    end
  end

  private
    def rows
      parser.rows
    end

    def import_factory
      @import_type ||= import_type.to_s.constantize
    end
end
