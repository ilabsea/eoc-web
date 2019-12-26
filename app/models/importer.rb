# frozen_string_literal: true

class Importer
  include ActiveModel::Validations
  include ActiveModel::Conversion

  VALID_IMPORT_TYPE = ["sop", "category"]

  validates :type, inclusion: { in: VALID_IMPORT_TYPE }

  attr_reader :parser, :type

  def initialize(attributes = {})
    @parser = attributes[:parser]
    @type = @parser.type
  end

  def import
    if valid?
      rows.each do |row|
        next if import_factory.find_by(name: row[:name]).present?
        import_factory.create_record(row)
      end
    end
  end

  def validate
    result = {
      valids: [],
      errors: [],
      exists: []
    }
    if valid?
      rows.each do |row|
        record = import_factory.build_record(row)
        if import_factory.find_by(name: row[:name]).present?
          result[:exists] << record
        elsif record.valid?
          result[:valids] << record
        else
          result[:errors] << record
        end
      end
    end
    result
  end

  private
    def rows
      parser.rows
    end

    def import_factory
      @import_factory ||= type.to_s.capitalize.constantize
    end
end
