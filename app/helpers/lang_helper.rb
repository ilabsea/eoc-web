# frozen_string_literal: true

class Lang
  def initialize(lang)
    @lang = lang
  end

  def name
    langs[@lang][:name]
  end

  def choices
    langs.delete(I18n.locale.to_sym)
    langs.values
  end

  private
    def langs
      @langs ||= {
        en: { name: "english", url: { locale: :en } },
        km: { name: "ខ្មែរ", url: { locale: :km } }
      }
    end
end

module LangHelper
  def lang
    Lang.new(I18n.locale)
  end
end
