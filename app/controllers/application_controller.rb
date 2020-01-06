# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  around_action :switch_locale

  layout :layout_by_resource

  private
    def layout_by_resource
      devise_controller? ? "minimal" : "application"
    end

    def switch_locale(&action)
      locale = current_user.try(:locale) || :en
      I18n.with_locale(locale, &action)
    end
end
