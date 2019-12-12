# frozen_string_literal: true

class ExcelParser::Parser
  include ActiveModel::Validations

  VALID_PARSER_TYPE = ["sop", "category"]

  validates :parser_type, inclusion: { in: VALID_PARSER_TYPE }

  attr_reader :parser_type, :excel_file

  def initialize(attributes)
    @excel_file = attributes[:excel_file]
    @parser_type = attributes[:parser_type]
  end

  def rows
    if valid?
      parser_factory.generate
    end
  end

  private
    def parser_factory
      @parser_type ||= "ExcelParser::#{parser_type.capitalize}Parser".constantize
    end
end
