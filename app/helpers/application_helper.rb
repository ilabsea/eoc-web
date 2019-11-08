# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    prefix = params["controller"].downcase.split("/").join("-")
    subfix = params["action"]

    "#{prefix}-#{subfix}"
  end
end
