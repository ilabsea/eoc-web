# frozen_string_literal: true

class ExcelParser::Parser
  include ActiveModel::Validations

  VALID_PARSER_TYPE = ["sop", "category"]

  validates :type, inclusion: { in: VALID_PARSER_TYPE }

  attr_reader :type, :file

  def initialize(attributes)
    @file = attributes[:file]
    @type = attributes[:type]
  end

  def rows
    if valid?
      parser_factory.generate(@file)
    end
  end

  private
    def parser_factory
      @parser_type ||= "ExcelParser::#{type.capitalize}Parser".constantize
    end
end
