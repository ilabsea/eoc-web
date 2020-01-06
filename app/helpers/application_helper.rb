# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    prefix = params["controller"].downcase.split("/").join("-")
    subfix = params["action"]

    "#{prefix}-#{subfix}"
  end

  def switch_language_data
    if current_user.locale == "km"
      {
        label: "ប្ដូរភាសារ៖",
        locale: "en",
        submit_label: "English"
      }
    else
      {
        label: "Change language:",
        locale: "km",
        submit_label: "ខ្មែរ"
      }
    end
  end
end
