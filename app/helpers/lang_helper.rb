# frozen_string_literal: true

module LangHelper
  def lang
    ::Lang.new(I18n.locale)
  end
end
