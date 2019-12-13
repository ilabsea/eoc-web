class Importer
  include ActiveModel::Validations
  include ActiveModel::Conversion

  VALID_IMPORT_TYPE = ["sop", "category"]

  validates :type, inclusion: { in: VALID_IMPORT_TYPE }

  attr_reader :parser, :type

  def initialize(attributes={})
    @parser = attributes[:parser]
    @type = attributes[:type]
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
      @type ||= type.to_s.capitalize.constantize
    end
end
